require 'test_helper'

class TempBillControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get temp_bill_new_url
    assert_response :success
  end

end
