require_relative './validator.rb'

class OrderValidator < Validator

    def initialize
        @rules = {
            :book_id => 'required|integer|exists:book',
            :reader_id => 'required|integer|exists:reader'
        }

        super
    end
    
end
