class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :destroy]
  def index
    @purchases = Purchase.all
  end

  def show
  end

  def new
    @purchase = Purchase.new
    @purchase.build_financial_transaction
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.build_financial_transaction(financial_transaction_params[:financial_transaction])

    unless validate_transaction_details @purchase
      render :new
      return
    end

    if @purchase.save
      finTrans = @purchase.financial_transaction
      finTrans.type_of_transaction = :credit
      if finTrans.save
        flash[:success] = "Purchase added!"
        redirect_to purchases_path
      end
    else
      render :new
    end
  end

  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:raw_material_id, :third_party_id, :qty, :batch_no, :expiry_date, :rate_of_unit, :remarks, :amount)
    end

    def financial_transaction_params
      params.require(:purchase).permit(:financial_transaction => [:amount, :payment_method])
    end

    # TODO : Check for better way to do this.
    def validate_transaction_details(purchaseObj)
      noError = true
      if financial_transaction_params[:financial_transaction][:amount].blank?
        purchaseObj.errors[:financial_transaction] << "Amount can not be empty"
        noError = false
      end
      return noError
    end
end
