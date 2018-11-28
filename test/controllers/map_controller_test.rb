require 'test_helper'

class MapControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get map_new_url
    assert_response :success
  end

  test "should get edit" do
    get map_edit_url
    assert_response :success
  end

  test "should get show" do
    get map_show_url
    assert_response :success
  end

end
