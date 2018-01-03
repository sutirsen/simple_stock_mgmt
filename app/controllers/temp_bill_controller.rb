class TempBillController < ApplicationController
  before_action :logged_in_user
  def new
  end

  def create
    @tmpBill = temp_bill_params
    rebate = @tmpBill['rebate']
    rebateType = 'flat'
    if rebate[-1] == '%'
      rebate = rebate[0..-2]
      rebateType = 'perc'
    end
    @tmpBill['rebate'] = rebate
    @tmpBill['rebateType'] = rebateType
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
