require 'test_helper'

class SubtypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subtype" do
    assert_difference('Subtype.count') do
      post :create, :subtype => subtypes(:one).attributes
    end

    assert_redirected_to subtype_path(assigns(:subtype))
  end

  test "should show subtype" do
    get :show, :id => subtypes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subtypes(:one).to_param
    assert_response :success
  end

  test "should update subtype" do
    put :update, :id => subtypes(:one).to_param, :subtype => subtypes(:one).attributes
    assert_redirected_to subtype_path(assigns(:subtype))
  end

  test "should destroy subtype" do
    assert_difference('Subtype.count', -1) do
      delete :destroy, :id => subtypes(:one).to_param
    end

    assert_redirected_to subtypes_path
  end
end
