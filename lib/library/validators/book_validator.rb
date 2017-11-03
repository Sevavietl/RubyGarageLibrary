require_relative './validator.rb'

class BookValidator < Validator

    def initialize
        @rules = {
            :title => 'required',
            :author_id => 'required|integer|exists:author'
        }

        super
    end
    
end
