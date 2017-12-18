class Form
    attr_reader :entity

    def initialize(entity)
        @entity = entity
    end

    def process
        if @entity.id
            process_update
        else
            process_create
        end

        self
    end

    def to_hash
        @entity.to_hash
    end

    private

    def process_create
        @entity.to_hash.each do |key, value|
            next if [:id, :date].include?(key)

            print "#{key}: "
            @entity.send("#{key}=", gets.strip)
        end
    end

    def process_update
        @entity.to_hash.each do |key, value|
            next if [:id, :date].include?(key)

            print "#{key} (#{value}): "
            
            input = gets.strip
            @entity.send("#{key}=", input) if input != ''
        end
    end
end
