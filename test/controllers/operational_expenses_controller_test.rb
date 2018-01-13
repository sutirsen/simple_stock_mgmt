require 'test_helper'

class OperationalExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operational_expense = operational_expenses(:one)
  end

  test "should get index" do
    get operational_expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_operational_expense_url
    assert_response :success
  end

  test "should create operational_expense" do
    assert_difference('OperationalExpense.count') do
      post operational_expenses_url, params: { operational_expense: { details: @operational_expense.details, name: @operational_expense.name, paid_on: @operational_expense.paid_on } }
    end

    assert_redirected_to operational_expense_url(OperationalExpense.last)
  end

  test "should show operational_expense" do
    get operational_expense_url(@operational_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_operational_expense_url(@operational_expense)
    assert_response :success
  end

  test "should update operational_expense" do
    patch operational_expense_url(@operational_expense), params: { operational_expense: { details: @operational_expense.details, name: @operational_expense.name, paid_on: @operational_expense.paid_on } }
    assert_redirected_to operational_expense_url(@operational_expense)
  end

  test "should destroy operational_expense" do
    assert_difference('OperationalExpense.count', -1) do
      delete operational_expense_url(@operational_expense)
    end

    assert_redirected_to operational_expenses_url
  end
end
