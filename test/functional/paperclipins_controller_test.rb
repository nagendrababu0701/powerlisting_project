require 'test_helper'

class PaperclipinsControllerTest < ActionController::TestCase
  setup do
    @paperclipin = paperclipins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paperclipins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paperclipin" do
    assert_difference('Paperclipin.count') do
      post :create, :paperclipin => { :upload_file => @paperclipin.upload_file }
    end

    assert_redirected_to paperclipin_path(assigns(:paperclipin))
  end

  test "should show paperclipin" do
    get :show, :id => @paperclipin
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @paperclipin
    assert_response :success
  end

  test "should update paperclipin" do
    put :update, :id => @paperclipin, :paperclipin => { :upload_file => @paperclipin.upload_file }
    assert_redirected_to paperclipin_path(assigns(:paperclipin))
  end

  test "should destroy paperclipin" do
    assert_difference('Paperclipin.count', -1) do
      delete :destroy, :id => @paperclipin
    end

    assert_redirected_to paperclipins_path
  end
end
