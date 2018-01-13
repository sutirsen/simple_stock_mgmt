class OperationalExpensesController < ApplicationController
  before_action :set_operational_expense, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  # GET /operational_expenses
  # GET /operational_expenses.json
  def index
    @operational_expenses = OperationalExpense.all
  end

  # GET /operational_expenses/1
  # GET /operational_expenses/1.json
  def show
  end

  # GET /operational_expenses/new
  def new
    @operational_expense = OperationalExpense.new
    @operational_expense.build_financial_transaction
  end

  # GET /operational_expenses/1/edit
  def edit
  end

  # POST /operational_expenses
  # POST /operational_expenses.json
  def create
    @operational_expense = OperationalExpense.new(operational_expense_params)
    @operational_expense.build_financial_transaction(financial_transaction_params[:financial_transaction])

    unless validate_transaction_details @operational_expense
      render :new
      return
    end


    respond_to do |format|
      if @operational_expense.save
        finTrans = @operational_expense.financial_transaction
        finTrans.type_of_transaction = :debit
        finTrans.save

        format.html { redirect_to @operational_expense, notice: 'Operational expense was successfully created.' }
        format.json { render :show, status: :created, location: @operational_expense }
      else
        format.html { render :new }
        format.json { render json: @operational_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operational_expenses/1
  # DELETE /operational_expenses/1.json
  def destroy
    @operational_expense.destroy
    respond_to do |format|
      format.html { redirect_to operational_expenses_url, notice: 'Operational expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operational_expense
      @operational_expense = OperationalExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operational_expense_params
      params.require(:operational_expense).permit(:name, :details, :paid_on)
    end

    def financial_transaction_params
      params.require(:operational_expense).permit(:financial_transaction => [:amount, :payment_method])
    end

    def validate_transaction_details(purchaseObj)
      noError = true
      if financial_transaction_params[:financial_transaction][:amount].blank?
        purchaseObj.errors[:financial_transaction] << "Amount can not be empty"
        noError = false
      end
      return noError
    end
end
