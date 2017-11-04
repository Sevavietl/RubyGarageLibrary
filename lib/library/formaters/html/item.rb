require_relative './helpers.rb'

module HtmlFormater
    
    class Item
        include Helpers

        def initialize(item)
            @item = item
        end
        
        def to_s()
            @string || format
        end

        def format
            template = '<tr>'.concat('<td>%s</td>' * 2).concat('</tr>')
            
            @string = '<table><tbody>%s</tbody></table>' % @item.to_hash.inject('') do |acc, (k, v)|
                acc.concat(template % [k.to_s.split('_').map { |s| s.capitalize }.join(' '), decorate_cell(k, v)])
            end

            @string
        end
    end

end
