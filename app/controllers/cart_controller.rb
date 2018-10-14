require 'json'
class CartController < ApplicationController
  before_action :logged_in_user
  # protect_from_forgery except: :add_product_to_cart
  def add_product_to_cart
    productToAdd = cart_params
    cartContent = Hash.new
    cartContent = convertCartContentToHash cookies[:cart]
    cartContent[productToAdd[:product_id]] = productToAdd[:qty]
    cookies[:cart] = { :value => convertCartHashToStr(cartContent), :expires => 1.year.from_now}
    render json: { status: 'ok' }.to_json
  end

  def remove_product_from_cart
    productId = cart_params[:product_id]
    cartContent = Hash.new
    cartContent = convertCartContentToHash cookies[:cart]
    cartContent.delete productId
    if cartContent.empty?
      cookies.delete(:cart)
      render json: { status: 'ok', cart_empty: true }.to_json
    else
      cookies[:cart] = { :value => convertCartHashToStr(cartContent), :expires => 1.year.from_now}
      render json: { status: 'ok' }.to_json
    end
  end

  def modify_tax_perc
    tax_id = tax_params[:tax_id]
    tax_operation = tax_params[:tax_operation]
    tax_value = tax_params[:tax_val] if tax_params[:tax_val]
    tax_data = JSON.parse(cookies['cartTaxes'])
    if tax_operation == 'MODIFY_PERC'
      if tax_data[tax_id]
        tax_detail = tax_data[tax_id]
        tax_detail['taxPerc'] = tax_value
        tax_data[tax_id] = tax_detail
      end
    elsif tax_operation == 'REMOVE_TAX'
      tax_data = tax_data.except(tax_id) if tax_data[tax_id]
    elsif tax_operation == 'RESET_TAX'
      fetched_taxes = Tax.where(is_active: true)
      tax_data = convert_tax_dbobj_to_hash fetched_taxes
    end
    cookies['cartTaxes'] = { value: tax_data.to_json,
                             expires: 1.year.from_now }
    render json: { status: 'ok' }.to_json
  end

  def index
    @returningAfterFreightLess = (params[:fl] == 't') ? true : false
    @taxEnabled = true
    if(params[:no_tax])
      @taxEnabled = false
    end
    cartHsh = convertCartContentToHash cookies[:cart]
    @cartDetails = Hash.new
    cartHsh.each do |productId, qty|
      @cartDetails[productId] = Hash.new
      @cartDetails[productId]['product'] = Product.find(productId)
      @cartDetails[productId]['addedQty'] = qty
    end

    @taxes = {}
    if cookies['cartTaxes']
      @taxes = JSON.parse(cookies['cartTaxes'])
    else
      fetched_taxes = Tax.where(is_active: true)
      @taxes = convert_tax_dbobj_to_hash fetched_taxes
    end

    cookies['cartTaxes'] = { value: @taxes.to_json,
                             expires: 1.year.from_now }

    @appliedCoupon = nil
    if cookies['coupon_applied']
      couponFetched = Coupon.find(cookies['coupon_applied'])
      if couponFetched.is_active? and couponFetched.valid_from < Time.now and couponFetched.valid_till > Time.now
        @appliedCoupon = couponFetched
      else
        # we might want to remove a stale cookie
      end
    end

    @freight_less = 0
    if cookies['freight_less']
      @freight_less = cookies['freight_less'].to_f
    end

    @order = Order.new

    @order.build_financial_transaction
    @order.build_transport

    # considering all params as error component
    errorsStatements = params.except(:action, :controller, :no_tax, :fl)
    errorsStatements.each do |errKey, errVal|
      @order.errors[errKey.to_sym] << errVal
    end
  end

  private

  def cart_params
    params.permit(:product_id, :qty)
  end

  def tax_params
    params.permit(:tax_id, :tax_val, :tax_operation)
  end

  def convert_tax_dbobj_to_hash(tax_db_obj)
    tax_hash = {}
    tax_db_obj.each do |fetched_tax|
      tax_item = {}
      tax_item['taxId'] = fetched_tax.id
      tax_item['taxName'] = fetched_tax.name
      tax_item['taxPerc'] = fetched_tax.perc
      tax_hash[fetched_tax.id] = tax_item
    end
    tax_hash
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

  def convertCartHashToStr(cartHsh)
    cartStr = ''
    cartHsh.each do |prodId, qty|
      cartStr += '|' if cartStr != ''
      cartStr += prodId + ',' + qty
    end
    return cartStr
  end
end