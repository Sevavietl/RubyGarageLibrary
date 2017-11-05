require './lib/library/validators/author_validator.rb'
require 'test/unit'

class TestAuthorValidator < Test::Unit::TestCase
    def self.startup
        @@validator = AuthorValidator.new
    end

    def test_fails
        input = {
            :name => 'Jack London',
            :biography => 'an American novelist, journalist, and social activist'
        }

        assert_false(@@validator.set_inputs(input).fails?)
        
        input = {
            :name => '',
            :biography => 'an American novelist, journalist, and social activist'
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['name is required'], @@validator.messages[:name])
        
        input = {
            :name => nil,
            :biography => 'an American novelist, journalist, and social activist'
        }

        assert_true(@@validator.set_inputs(input).fails?)
        assert_equal(['name is required'], @@validator.messages[:name])

        input = {
            :name => 'Jack London',
            :biography => ''
        }

        assert_false(@@validator.set_inputs(input).fails?)
    end
end
