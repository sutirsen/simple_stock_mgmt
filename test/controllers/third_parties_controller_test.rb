require 'test_helper'

class ThirdPartiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @third_party = third_parties(:one)
  end

  test "should get index" do
    get third_parties_url
    assert_response :success
  end

  test "should get new" do
    get new_third_party_url
    assert_response :success
  end

  test "should create third_party" do
    assert_difference('ThirdParty.count') do
      post third_parties_url, params: { third_party: { address: @third_party.address, due: @third_party.due, gst_number: @third_party.gst_number, name: @third_party.name, phn_number: @third_party.phn_number } }
    end

    assert_redirected_to third_party_url(ThirdParty.last)
  end

  test "should show third_party" do
    get third_party_url(@third_party)
    assert_response :success
  end

  test "should get edit" do
    get edit_third_party_url(@third_party)
    assert_response :success
  end

  test "should update third_party" do
    patch third_party_url(@third_party), params: { third_party: { address: @third_party.address, due: @third_party.due, gst_number: @third_party.gst_number, name: @third_party.name, phn_number: @third_party.phn_number } }
    assert_redirected_to third_party_url(@third_party)
  end

  test "should destroy third_party" do
    assert_difference('ThirdParty.count', -1) do
      delete third_party_url(@third_party)
    end

    assert_redirected_to third_parties_url
  end
end
