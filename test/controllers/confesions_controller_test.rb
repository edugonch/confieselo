require 'test_helper'

class ConfesionsControllerTest < ActionController::TestCase
  setup do
    @confesion = confesions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confesions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confesion" do
    assert_difference('Confesion.count') do
      post :create, confesion: { anonymous: @confesion.anonymous, message: @confesion.message, tittle: @confesion.tittle }
    end

    assert_redirected_to confesion_path(assigns(:confesion))
  end

  test "should show confesion" do
    get :show, id: @confesion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confesion
    assert_response :success
  end

  test "should update confesion" do
    patch :update, id: @confesion, confesion: { anonymous: @confesion.anonymous, message: @confesion.message, tittle: @confesion.tittle }
    assert_redirected_to confesion_path(assigns(:confesion))
  end

  test "should destroy confesion" do
    assert_difference('Confesion.count', -1) do
      delete :destroy, id: @confesion
    end

    assert_redirected_to confesions_path
  end
end
