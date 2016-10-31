require 'test_helper'

class LeaderboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get all time" do
    get root_url, params: { season: 'all' }
    assert_response :success
  end

  test "should get a season" do
    get root_url, params: { season: '2015-03-02' }
    assert_response :success
  end

  test "should still work with bad data" do
    get root_url, params: { season: 'jojojo' }
    assert_response :success
  end
end
