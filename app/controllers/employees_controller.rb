require 'pp';
class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @companies = Array.new
    fetchedCompanies = Company.all
    fetchedCompanies.each do |company|
      @companies << [company.company_name, company.id]
    end
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      format.html { render :new }
    end
    # respond_to do |format|
    #   if @employee.save
    #     format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
    #     format.json { render :show, status: :created, location: @employee }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @employee.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :company_id, :address, :voter_card_no, :aadhar_card_no, :pan_no, :date_of_joining, :designation, :type_of_work, :job_desc, :terms)
    end
end
