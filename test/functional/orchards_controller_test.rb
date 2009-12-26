require 'test_helper'

class OrchardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orchards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orchard" do
    assert_difference('Orchard.count') do
      post :create, :orchard => { }
    end

    assert_redirected_to orchard_path(assigns(:orchard))
  end

  test "should show orchard" do
    get :show, :id => orchards(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orchards(:one).to_param
    assert_response :success
  end

  test "should update orchard" do
    put :update, :id => orchards(:one).to_param, :orchard => { }
    assert_redirected_to orchard_path(assigns(:orchard))
  end

  test "should destroy orchard" do
    assert_difference('Orchard.count', -1) do
      delete :destroy, :id => orchards(:one).to_param
    end

    assert_redirected_to orchards_path
  end
end
