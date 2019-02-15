require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get assignments" do
    get reports_assignments_url
    assert_response :success
  end

end
