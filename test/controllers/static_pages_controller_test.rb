require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get cms" do
    get :cms
    assert_response :success
  end

end
