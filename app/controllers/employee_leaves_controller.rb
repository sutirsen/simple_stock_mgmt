class EmployeeLeavesController < ApplicationController
  before_action :logged_in_user
  before_action :get_employee
  before_action :get_leave, only: [:edit, :update, :destroy]
  def index
    @leaves = allLeaveTypes
    @leavesTaken = allLeaves
    @newLeaveTrans = LeaveTransaction.new
  end

  def new
    @employee_leave = @employee.employee_leave.build
  end

  def create
    @employee_leave = @employee.employee_leave.build(leave_params)
    @employee_leave.financial_year = Time.current.year
    if @employee_leave.save
      flash[:success] = "Leave added!"
      redirect_to employee_employee_leaves_path(@employee)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @employee_leave.update(leave_params)
      flash[:success] = "Updated the leave type!"
      redirect_to employee_employee_leaves_path(@employee)
    else
      render 'new'
    end
  end

  def destroy
    @employee_leave.destroy
    flash[:success] = "Removed the leave type!"
    redirect_to employee_employee_leaves_path(@employee)
  end

  def addLeave
    @leaves = allLeaveTypes
    @leavesTaken = allLeaves
    @newLeaveTrans = LeaveTransaction.new(leave_transaction_params)
    if @newLeaveTrans.save
      flash[:success] = "Leave applied!"
      redirect_to employee_employee_leaves_path(@employee)
    else
      render 'index'
    end
  end

  private

    def leave_transaction_params
      params.require(:leave_transaction).permit(:employee_id, :employee_leave_id, :start_date, :end_date, :description)
    end

    def leave_params
      params.require(:employee_leave).permit(:type_of_leave, :leave_amount)
    end

    def get_leave
      @employee_leave = @employee.employee_leave.find(params[:id])
    end

    def get_employee
      empId = params[:employee_id]
      @employee = Employee.find_by(id: empId)
      if @employee.nil?
        flash[:danger] = "Unable to find employee!"
        redirect_to root_url
      end
    end

    def allLeaveTypes
      @employee.employee_leave.where(financial_year: Time.current.year) || []
    end

    def allLeaves
      LeaveTransaction.where("employee_id = :emp_id AND start_date BETWEEN :start AND :end",
                                            emp_id: @employee.id,
                                            start: "#{Time.current.year}-01-01",
                                            end:   "#{Time.current.year}-12-31")
    end
end
