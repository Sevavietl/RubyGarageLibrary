require_relative './entity.rb'

class Author < Entity
    public_class_method :new
    
    attr_accessor :id, :name, :biography
end
