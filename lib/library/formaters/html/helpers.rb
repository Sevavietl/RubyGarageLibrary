module HtmlFormater
    
    module Helpers
        def decorate_cell(key, value)
            /^([a-zA-Z]+)_id$/.match(key.to_s) ? ('<a href="/%s/%d">%s</a>' % [$1, value, value]) : value
        end
    end

end
