module AsciiFormater
    
    class Table

        def initialize(items)
            @items = items
            calculate_column_lengthes
        end
        
        def to_s()
            @table || format
        end

        def format
            @table ||= header + body + footer

            return @table
        end

        private

        def calculate_column_lengthes
            attributes = @items.first&.to_hash.keys

            @column_lengthes = [@items, attributes.zip(attributes).to_h].flatten
                .inject(Hash[attributes.map { |x| [x, 0] }]) do |acc, item|
                    attributes.each { |attr| acc[attr] = [acc[attr], item.to_hash[attr].to_s.length].max }
                    acc
                end
        end

        def header
            template = hr.concat(@column_lengthes.values.inject('|'){ |acc, l| acc.concat "%-#{l}s|"}
                .concat("\n"))
                .concat(hr)
            template % @column_lengthes.keys.map{ |k| k.to_s.split('_').map { |s| s.capitalize }.join(' ') }
        end

        def body
            template = @column_lengthes.values.inject('|'){ |acc, l| acc.concat "%-#{l}s|"}.concat("\n")
            @items.map { |item| template % item.to_hash.values }.join()
        end

        def footer
            hr
        end

        def hr
            ('-' * @column_lengthes.values.inject(1){ |acc, v| acc + v + 1 }).concat("\n")
        end

    end

end
