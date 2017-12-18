require './lib/library/entities/book.rb'
require 'test/unit'

class TestBook < Test::Unit::TestCase

    def test_attributes
        assert_equal([:id, :title, :author_id], Book.attributes)
    end

end
