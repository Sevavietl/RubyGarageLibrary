require_relative './entity.rb'

class Book < Entity
    public_class_method :new
    
    attr_accessor :id, :title, :author_id
end
