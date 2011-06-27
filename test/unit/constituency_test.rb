require 'test_helper'

class ConstituencyTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Constituency.new.valid?
  end
end
