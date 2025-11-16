require "test_helper"

class Public::StickersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_stickers_index_url
    assert_response :success
  end

  test "should get show" do
    get public_stickers_show_url
    assert_response :success
  end
end
