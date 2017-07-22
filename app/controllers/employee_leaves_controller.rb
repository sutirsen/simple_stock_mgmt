class EmployeeLeavesController < ApplicationController
  before_action :get_employee
  def new
    @employee_leave = @employee.employee_leave.build
  end
  
  def create
    @employee_leave = @employee.employee_leave.build(leave_params)
    @employee_leave.financial_year = Time.current.year
    if @employee_leave.save
      flash[:success] = "Leave added!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  private
    
    def leave_params
      params.require(:employee_leave).permit(:type_of_leave, :leave_amount)
    end
    
    def get_employee
      empId = params[:employee_id]
      @employee = Employee.find_by(id: empId)
      if @employee.nil?
        flash[:danger] = "Unable to find employee!"
        redirect_to root_url
      end
    end
end
