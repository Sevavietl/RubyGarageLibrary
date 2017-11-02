class Repo
    class << self
        attr_accessor :adapter

        def find(klass, id)
            create_entity(klass, adapter.find(klass, id))
        end
    
        def all(klass)
            adapter.all(klass).map { |hash| create_entity(klass, hash) }
        end
    
        def create(entity)
            klass = entity.class
            create_entity(klass, adapter.create(klass, entity.to_hash))
        end
    
        def update(entity)
            klass = entity.class
            create_entity(klass, adapter.update(klass, entity.to_hash))
        end
    
        def delete(entity)
            adapter.delete(entity.class, entity.to_hash)
        end

        def query(klass, selector)
            adapter.query(klass, selector).map { |datum| create_entity(klass, datum) }
        end
    
        private
    
        def create_entity(klass, hash)
            hash ? klass.new(hash) : nil
        end    
    end
end
