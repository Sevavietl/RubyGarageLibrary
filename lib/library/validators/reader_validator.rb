require_relative './validator.rb'

class ReaderValidator < Validator

    def initialize
        @rules = {
            :name => 'required',
            :email => 'required|email|unique:reader:email', 
            :city => 'required',
            :street => 'required',
            :house => 'required'
        }

        super
    end
    
end
