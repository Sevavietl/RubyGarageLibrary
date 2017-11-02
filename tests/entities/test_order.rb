require './lib/library/entities/order.rb'
require 'test/unit'

class TestOrder < Test::Unit::TestCase

    def test_attributes
        assert_equal([:id, :book_id, :reader_id, :date], Order.attributes)
    end

end
