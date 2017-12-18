require_relative './table.rb'
require_relative './item.rb'

module AsciiFormater
    
    class Formater
        
        def table(items)
           Table.new items
        end

        def item(item)
            Item.new item
        end

    end

end
