require 'csv'

class CsvAdapter

    def initialize(folder)
        @folder = folder
    end

    def create(klass, record)
        record[:id] = generate_id(klass)
        records = read_file(klass)

        CSV.open(file_name(klass), 'w') do |csv|
            csv.puts records.headers

            records.each{ |row| csv.puts row }

            csv.puts hydrate_row(CSV::Row.new(records.headers, []), record)
        end

        record
    end

    def update(klass, record)
        records = read_file(klass)
        
        CSV.open(file_name(klass), 'w') do |csv|
            csv.puts records.headers

            records.each{ |row| csv.puts row[:id] == record[:id] ? hydrate_row(row, record) : row }
        end

        record
    end

    def delete(klass, record)
        records = read_file(klass)

        CSV.open(file_name(klass), 'w') do |csv|
            csv.puts records.headers

            records.each{ |row| csv.puts row unless row[:id] == record[:id] }
        end
    end

    def all(klass)
        read_file(klass).inject([]) do |rows, row|
            rows << row.to_h
        end
    end

    def find(klass, id)
        read_file(klass).find { |row| row[:id] == id }&.to_h
    end

    def query(klass, selector)
        field, sign, value = selector.values_at(:field, :sign, :value)

        read_file(klass).select{ |row| row[field].send(sign, value) }
    end

    private

    def read_file(klass)
        CSV.read(file_name(klass), :headers => true, :converters => :all, :header_converters => :symbol)
    end

    def file_name(klass)
        @folder + klass.to_s.downcase + '.csv'
    end

    def generate_id(klass)
        read_file(klass).size + 1
    end

    def hydrate_row(row, hash)
        hash.each { |key, value| row[key] = value }
        
        return row
    end

end