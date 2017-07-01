require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post companies_url, params: { company: { authorized_sign_img: @company.authorized_sign_img, branch_name: @company.branch_name, company_logo_img: @company.company_logo_img, company_name: @company.company_name, cst_number: @company.cst_number, drug_license_number: @company.drug_license_number, email: @company.email, ph_number: @company.ph_number, registration_number: @company.registration_number, trade_license_number: @company.trade_license_number, vat_number: @company.vat_number, web_site: @company.web_site } }
    end

    assert_redirected_to company_url(Company.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { authorized_sign_img: @company.authorized_sign_img, branch_name: @company.branch_name, company_logo_img: @company.company_logo_img, company_name: @company.company_name, cst_number: @company.cst_number, drug_license_number: @company.drug_license_number, email: @company.email, ph_number: @company.ph_number, registration_number: @company.registration_number, trade_license_number: @company.trade_license_number, vat_number: @company.vat_number, web_site: @company.web_site } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end
end
