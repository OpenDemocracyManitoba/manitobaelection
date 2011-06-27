require 'test_helper'

class ConstituenciesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Constituency.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Constituency.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Constituency.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to constituency_url(assigns(:constituency))
  end

  def test_edit
    get :edit, :id => Constituency.first
    assert_template 'edit'
  end

  def test_update_invalid
    Constituency.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Constituency.first
    assert_template 'edit'
  end

  def test_update_valid
    Constituency.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Constituency.first
    assert_redirected_to constituency_url(assigns(:constituency))
  end

  def test_destroy
    constituency = Constituency.first
    delete :destroy, :id => constituency
    assert_redirected_to constituencies_url
    assert !Constituency.exists?(constituency.id)
  end
end
