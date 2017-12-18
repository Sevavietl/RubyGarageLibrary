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
        raise TypeError unless entity < Entity

        regex = /^([_a-zA-Z]+)_id$/

        entity.attributes.inject([]) do |acc, attr|
            acc.push(get_entity($1)) if regex.match(attr.to_s)
            acc
        end
        .compact
    end

    def get_repo(entity)
        get_class('%sRepo', ensure_entity(entity))
    end

    def get_validator(entity)
        get_class('%sValidator', ensure_entity(entity))
    end

    def get_entity(name)
        ensure_entity(name)
    end

    private

    def ensure_entity(entity_or_name)
        entity = case entity_or_name
            when String
                get_class('%s', entity_or_name.capitalize)
            when Class
                entity_or_name
            else
                nil
        end

        (entity && entity < Entity) ? entity : nil
    end

    def get_class(pattern, subject)
        begin
            raise NameError if subject == nil
            Object.const_get(pattern % subject)
        rescue NameError
            nil
        end
    end
end