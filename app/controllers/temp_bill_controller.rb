class TempBillController < ApplicationController
  def new
  end

  def create
    @tmpBill = temp_bill_params
    @cgstRate = @tmpBill['cgst'].to_f
    @sgstRate = @tmpBill['sgst'].to_f
    respond_to do |format|
      format.html
      format.pdf do
        render layout: "invoice", pdf: "invoice"   # Excluding ".pdf" extension.
      end
    end
  end

  private
    def temp_bill_params
      params.require(:tmpbill).permit!
    end
end
