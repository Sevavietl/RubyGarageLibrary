require_relative './entity.rb'

class Order < Entity
    public_class_method :new
    
    attr_accessor :id, :book_id, :reader_id, :date
end
