require "./lib/library.rb"
require "test/unit"

class TestLibrary < Test::Unit::TestCase

  def test_sample
    assert_equal(4, 2+2)
  end

end