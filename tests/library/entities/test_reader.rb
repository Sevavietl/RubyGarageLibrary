require './lib/library/entities/reader.rb'
require 'test/unit'

class TestReader < Test::Unit::TestCase

    def test_attributes
        assert_equal([:id, :name, :email, :city, :street, :house], Reader.attributes)
    end

end
