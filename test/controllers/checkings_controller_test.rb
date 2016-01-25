require 'test_helper'

class CheckingsControllerTest < ActionController::TestCase
  setup do
    @checking = checkings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checking" do
    assert_difference('Checking.count') do
      post :create, checking: {  }
    end

    assert_redirected_to checking_path(assigns(:checking))
  end

  test "should show checking" do
    get :show, id: @checking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checking
    assert_response :success
  end

  test "should update checking" do
    patch :update, id: @checking, checking: {  }
    assert_redirected_to checking_path(assigns(:checking))
  end

  test "should destroy checking" do
    assert_difference('Checking.count', -1) do
      delete :destroy, id: @checking
    end

    assert_redirected_to checkings_path
  end
end
