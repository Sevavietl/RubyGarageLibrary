require './lib/library/entities/author.rb'
require 'test/unit'

class TestAuthor < Test::Unit::TestCase

    def test_attributes
        assert_equal([:id, :name, :biography], Author.attributes)
    end

end
