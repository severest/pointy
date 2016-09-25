require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_new_url
    assert_response :success
  end

  test "should post create" do
    post game_create_url, params: { game: { name: 'John', points: 6, winner: false } }
    assert_redirected_to root_url
  end

  test "should not post create without name" do
    post game_create_url, params: { game: { points: 6, winner: false } }
    assert_response :bad_request
  end

  test "should not post create without points" do
    post game_create_url, params: { game: { name: 'John', winner: false } }
    assert_response :bad_request
  end

  test "should not post create without wins" do
    post game_create_url, params: { game: { name: 'John', points: 6 } }
    assert_response :bad_request
  end

  test "should not post create with bad points" do
    post game_create_url, params: { game: { name: 'John', points: 'heelo6', winner: true } }
    assert_response :bad_request
  end

  test "should not post create with negative points" do
    post game_create_url, params: { game: { name: 'John', points: -2, winner: true } }
    assert_response :bad_request
  end
  
  test "should not post create with decimal points" do
    post game_create_url, params: { game: { name: 'John', points: 2.9, winner: true } }
    assert_response :bad_request
  end
end
