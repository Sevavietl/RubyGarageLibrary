class Entity
    private_class_method :new

    def self.attr_accessor *vars
        @attributes ||= []
        @attributes.concat vars
        super(*vars)
    end

    def self.attributes
        @attributes
    end

    def initialize params = {}
        self.attributes.each { |key| send "#{key}=", params[key] if params.key?(key) }
    end
    
    def to_hash
        self.attributes.inject({}) do |acc, a|          
            acc[a] = self.send(a)
            acc
        end
    end

    def attributes
        self.class.attributes
    end
end
