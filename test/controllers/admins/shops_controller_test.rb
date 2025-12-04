require "test_helper"

class Admins::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_shops_new_url
    assert_response :success
  end

  test "should get edit" do
    get admins_shops_edit_url
    assert_response :success
  end
end
