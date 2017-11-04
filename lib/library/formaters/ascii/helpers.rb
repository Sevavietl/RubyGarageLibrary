module AsciiFormater
    
    module Helpers
        def hr
            ('-' * @column_lengthes.values.inject(1){ |acc, v| acc + v + 1 }).concat("\n")
        end
    end

end
