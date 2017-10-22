require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_index_url
    assert_response :success
  end

  test "should get brand" do
    get main_brand_url
    assert_response :success
  end

  test "should get search" do
    get main_search_url
    assert_response :success
  end

  test "should get detail" do
    get main_detail_url
    assert_response :success
  end

end
