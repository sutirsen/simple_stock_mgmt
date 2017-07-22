require 'test_helper'

class EmployeeLeaveControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employee_leave_new_url
    assert_response :success
  end

end
