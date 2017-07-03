require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { aadhar_card_no: @employee.aadhar_card_no, address: @employee.address, company_id: @employee.company_id, date_of_joining: @employee.date_of_joining, designation: @employee.designation, job_desc: @employee.job_desc, name: @employee.name, pan_no: @employee.pan_no, terms: @employee.terms, type_of_work: @employee.type_of_work, voter_card_no: @employee.voter_card_no } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { aadhar_card_no: @employee.aadhar_card_no, address: @employee.address, company_id: @employee.company_id, date_of_joining: @employee.date_of_joining, designation: @employee.designation, job_desc: @employee.job_desc, name: @employee.name, pan_no: @employee.pan_no, terms: @employee.terms, type_of_work: @employee.type_of_work, voter_card_no: @employee.voter_card_no } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
