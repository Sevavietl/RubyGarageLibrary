require './lib/library/repos/repo.rb'
require './lib/library/repos/reader_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require './lib/library/validators/reader_validator.rb'
require 'test/unit'

class TestReaderValidator < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
        @@validator = ReaderValidator.new
    end

    def test_fails
        input = {
            :name => 'John Doe',
            :email => 'john@doe.com', 
            :city => 'City',
            :street => 'Street',
            :house => '1'
        }

        assert_false(@@validator.set_inputs(input).fails?)
        
        input = {
            :name => 'John Doe',
            :email => 'john@dow.com', 
            :city => 'City',
            :street => 'Street',
            :house => '1'
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['email must be unique'], @@validator.messages[:email])
        
        input = {
            :name => 'John Doe',
            :email => '', 
            :city => 'City',
            :street => 'Street',
            :house => '1'
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['email is required', 'email must be an email'], @@validator.messages[:email])
    end
end
