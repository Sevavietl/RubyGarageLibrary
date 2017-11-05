require './lib/library/repos/repo.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/repos/reader_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require './lib/library/validators/order_validator.rb'
require 'test/unit'

class TestOrderValidator < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
        @@validator = OrderValidator.new
    end

    def test_fails
        input = {
            :book_id => 1,
            :reader_id => 1
        }

        assert_false(@@validator.set_inputs(input).fails?)
        
        input = {
            :book_id => 25,
            :reader_id => 25
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['book_id must exist'], @@validator.messages[:book_id])
        assert_equal(['reader_id must exist'], @@validator.messages[:reader_id])
    end
end
