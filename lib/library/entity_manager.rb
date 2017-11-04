Dir['./lib/library/entities/*.rb'].sort.each { |file| require file }
Dir['./lib/library/repos/*.rb'].sort.each { |file| require file }
Dir['./lib/library/validators/*.rb'].sort.each { |file| require file }

class EntityManager
    def find(entity, id)
        get_repo(entity).find(id)
    end

    def get_relatives(entity)
        get_relations(entity.class).inject({}) do |acc, e|
            acc[e] = get_repo(e).find(entity.send("#{e.to_s.downcase}_id".to_sym))
            acc
        end
        .compact
    end

    def get_relations(entity)
        raise TypeError unless entity< Entity

        regex = /^([_a-zA-Z]+)_id$/

        entity.attributes.select { |attr| regex.match(attr.to_s) }
            .map { |attr| regex.match(attr.to_s) && get_entity($1) }
            .compact
    end

    def get_repo(entity)
        entity = get_entity(entity) if entity.is_a? String

        begin
            entity && Object.const_get("#{entity.to_s}Repo")
        rescue NameError
            nil
        end
    end

    def get_validator(entity)
        entity = get_entity(entity) if entity.is_a? String
        
        begin
            entity && Object.const_get("#{entity.to_s}Validator")
        rescue NameError
            nil
        end
    end

    def get_entity(name)
        begin
            entity = Object.const_get("#{name.capitalize}")

            raise NameError.new unless entity < Entity

            entity
        rescue NameError
            nil
        end
    end
end