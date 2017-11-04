require_relative './helpers.rb'

module AsciiFormater
    
    class Item
        include Helpers

        def initialize(item)
            @item = item
            calculate_column_lengthes
        end
        
        def to_s()
            @string || format
        end

        def format
            template = @column_lengthes.values.inject('|'){ |acc, l| acc.concat("%#{l}s|") }.concat("\n")
            
            @string = hr.concat(@item.to_hash.inject('') do |acc, (k, v)|
                acc.concat(template % [k.to_s.split('_').map { |s| s.capitalize }.join(' '), v])
            end).concat(hr)
            @string
        end

        private

        def calculate_column_lengthes
            @column_lengthes = {}

            @column_lengthes[0] = @item.to_hash.keys.inject(0) do |max, attr|
                [max, attr.to_s.length].max
            end

            @column_lengthes[1] = @item.to_hash.values.inject(0) do |max, v|
                [max, v.to_s.length].max
            end
        end
    end

end
