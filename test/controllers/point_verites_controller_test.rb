require 'test_helper'

class PointVeritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @point_verite = point_verites(:one)
  end

  test "should get index" do
    get point_verites_url
    assert_response :success
  end

  test "should get new" do
    get new_point_verite_url
    assert_response :success
  end

  test "should create point_verite" do
    assert_difference('PointVerite.count') do
      post point_verites_url, params: { point_verite: { person_id: @point_verite.person_id, value: @point_verite.value } }
    end

    assert_redirected_to point_verite_url(PointVerite.last)
  end

  test "should show point_verite" do
    get point_verite_url(@point_verite)
    assert_response :success
  end

  test "should get edit" do
    get edit_point_verite_url(@point_verite)
    assert_response :success
  end

  test "should update point_verite" do
    patch point_verite_url(@point_verite), params: { point_verite: { person_id: @point_verite.person_id, value: @point_verite.value } }
    assert_redirected_to point_verite_url(@point_verite)
  end

  test "should destroy point_verite" do
    assert_difference('PointVerite.count', -1) do
      delete point_verite_url(@point_verite)
    end

    assert_redirected_to point_verites_url
  end
end
