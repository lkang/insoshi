require 'test_helper'

class GuitarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guitars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guitar" do
    assert_difference('Guitar.count') do
      post :create, :guitar => { }
    end

    assert_redirected_to guitar_path(assigns(:guitar))
  end

  test "should show guitar" do
    get :show, :id => guitars(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => guitars(:one).id
    assert_response :success
  end

  test "should update guitar" do
    put :update, :id => guitars(:one).id, :guitar => { }
    assert_redirected_to guitar_path(assigns(:guitar))
  end

  test "should destroy guitar" do
    assert_difference('Guitar.count', -1) do
      delete :destroy, :id => guitars(:one).id
    end

    assert_redirected_to guitars_path
  end
end
