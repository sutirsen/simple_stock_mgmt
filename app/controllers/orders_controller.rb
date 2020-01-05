require 'json'
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :invoice]
  before_action :logged_in_user
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order("bill_date DESC").all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    redirect_to '/cart'
  end

  # GET /orders/1/edit
  def edit
  end

  def invoice
    @invoice_type = "normal"
    if params['invoice_type']
      @invoice_type = params['invoice_type']
    end
    @taxes = OrderTax.where(order_id: @order.id)
    @taxes = Tax.where(is_active: true) if @taxes.count.zero?
    respond_to do |format|
      format.html
      format.pdf do
        if @invoice_type == "voucher"
          render layout: "invoice", template: "orders/voucher", pdf: "voucher"   # Excluding ".pdf" extension.
        else 
          render layout: "invoice", pdf: "invoice"   # Excluding ".pdf" extension.
        end
      end
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.build_financial_transaction(financial_transaction_params[:financial_transaction])
    @order.build_transport(transport_params[:transport])

    # Start all validations

    errorDesc = validate_transaction_details @order
    if not errorDesc.empty?
      redirect_to '/cart?' + errorDesc.to_query 
      return
    end

    # All validation was successful 
    if @order.save
      finTrans = @order.financial_transaction
      finTrans.type_of_transaction = :credit
      finTrans.save

      transport = @order.transport
      transport.save

      # Now we gather up order items 
      cartHsh = convertCartContentToHash cookies[:cart]
      cartHsh.each do |productId, qty|
        productObj = Product.find(productId)
        orderItm = OrderItem.new
        orderItm.order = @order
        orderItm.product = productObj
        orderItm.qty = qty
        if productObj.trading_price && productObj.trading_price != 0
          orderItm.selling_price = productObj.trading_price
        else
          orderItm.selling_price = productObj.mrp
        end
        orderItm.total_item_cost = qty.to_i * orderItm.selling_price.to_f
        orderItm.save
      end

      # remove cookie
      cookies.delete :cart

      # Now we collect taxes
      taxes_hash = JSON.parse(cookies['cartTaxes'])
      taxes_hash.each do |tax_id, tax|
        tax_obj = Tax.find(tax_id)
        order_tax_item = OrderTax.new
        order_tax_item.tax = tax_obj
        order_tax_item.order = @order
        order_tax_item.tax_val = tax['taxPerc']
        order_tax_item.save
      end

      # remove tax cookie
      cookies.delete 'cartTaxes'

      if cookies['coupon_applied']
        cookies.delete :coupon_applied
      end
      flash[:success] = "Order complete!"
      redirect_to orders_path
    else
      redirect_to '/cart?' + { server_error: 'Something went wrong!' }.to_query 
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was removed!' }
      format.json { head :no_content }
    end
  end

  def apply_freight_less
    freightLessDeduction = params.permit(:freight_less)['freight_less']
    cookies['freight_less'] = { :value => freightLessDeduction, :expires => 1.year.from_now}
    render json: { status: 'ok', msg: 'Freight less deduction was successfully applied!' }.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def financial_transaction_params
      params.require(:order).permit(:financial_transaction => [:amount, :payment_method])
    end

    def transport_params
      params.require(:order).permit(:transport => [:name, :documents_through, :no_of_cases, :contact_no])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:third_party_id, :freight_less, :total_cost, :total_tax, :discounted_amount, :total_payable, :coupon_id, :bill_date, :bill_no, :tr_no, :place_of_delivery, :with_tax, :remarks)
    end

    def validate_transaction_details(orderObj)
      errorHsh = Hash.new
      if financial_transaction_params[:financial_transaction][:amount].blank?
        errorHsh[:financial_transaction] = "Amount can not be empty"
      end
      return errorHsh
    end

    def convertCartContentToHash(cartStr)
      tmpHsh = Hash.new
      if(cartStr and cartStr != "")
        allItems = cartStr.split('|')
        allItems.each do |itm|
          itm = itm.split(',')
          tmpHsh[itm[0]] = itm[1]
        end
      end
      return tmpHsh
    end
end
