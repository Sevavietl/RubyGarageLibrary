require './lib/library/repos/repo.rb'
require './lib/library/repos/author_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require './lib/library/validators/book_validator.rb'
require 'test/unit'

class TestBookValidator < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
        @@validator = BookValidator.new
    end

    def test_fails
        input = {
            :title => 'Wee Willie Winkie and Other Child Stories',
            :author_id => 1
        }

        assert_false(@@validator.set_inputs(input).fails?)
        
        input = {
            :title => '',
            :author_id => 25
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['title is required'], @@validator.messages[:title])
        assert_equal(['author_id must exist'], @@validator.messages[:author_id])

        input = {
            :title => 'Wee Willie Winkie and Other Child Stories',
            :author_id => '1.2'
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['author_id must be an integer', 'author_id must exist'], @@validator.messages[:author_id])
    end
end
