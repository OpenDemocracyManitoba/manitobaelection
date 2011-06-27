require 'test_helper'

class PoliticiansControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Politician.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Politician.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Politician.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to politician_url(assigns(:politician))
  end

  def test_edit
    get :edit, :id => Politician.first
    assert_template 'edit'
  end

  def test_update_invalid
    Politician.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Politician.first
    assert_template 'edit'
  end

  def test_update_valid
    Politician.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Politician.first
    assert_redirected_to politician_url(assigns(:politician))
  end

  def test_destroy
    politician = Politician.first
    delete :destroy, :id => politician
    assert_redirected_to politicians_url
    assert !Politician.exists?(politician.id)
  end
end
