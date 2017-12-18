require_relative './validator.rb'

class AuthorValidator < Validator

    def initialize
        @rules = {
            :name => 'required'
        }

        super
    end
    
end