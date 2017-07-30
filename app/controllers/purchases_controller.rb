class PurchasesController < ApplicationController
  def index
  end

  def new
    @purchase = Purchase.new
    @purchase.build_financial_transaction
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.build_financial_transaction(purchase_params[:financial_transaction])
    if @purchase.save
      puts "Done!"
    else
      render :new
    end
  end
  
  private
    def purchase_params
      params.require(:purchase).permit(:rate_of_unit, :financial_transaction => [:amount])
    end
end
