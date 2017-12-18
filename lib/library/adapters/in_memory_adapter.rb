class InMemoryAdapter

    def initialize(data = {})
        @data = data
        @data.default = {}
    end

    def create(klass, record)
        klass_sym = get_sym(klass)
        
        record[:id] = generate_id(klass_sym)
        @data[klass_sym][record[:id]] = record
        record
    end

    def update(klass, record)
        @data[get_sym(klass)][record[:id]] = record
        record
    end

    def delete(klass, record)
        @data[get_sym(klass)].delete(record[:id])
    end

    def all(klass)
        @data[get_sym(klass)].inject([]) { |rows, (_, row)| rows << row.to_h }
    end

    def find(klass, id)
        @data[get_sym(klass)][id]&.to_h
    end

    def query(klass, selector)
        field, sign, value = selector.values_at(:field, :sign, :value)

        @data[get_sym(klass)].select{ |_, row| row[field].send(sign, value) }.values
    end

    private

    def generate_id(klass)
        (@data[klass].keys.max || 0) + 1
    end

    def get_sym(klass)
        klass.to_s.to_sym
    end

end