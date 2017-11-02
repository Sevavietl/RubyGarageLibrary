require_relative './entity.rb'

class Reader < Entity
    public_class_method :new
    
    attr_accessor :id, :name, :email, :city, :street, :house
end
