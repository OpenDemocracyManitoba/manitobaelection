require 'test_helper'

class PoliticianTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Politician.new.valid?
  end
end
