require 'test_helper'

class NewsArticlesControllerTest < ActionController::TestCase
  def test_show
    get :show, :id => NewsArticle.first
    assert_template 'show'
  end

  def test_index
    get :index
    assert_template 'index'
  end
end
