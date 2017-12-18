require_relative './helpers.rb'

module HtmlFormater
    
    class Table

        include Helpers

        def initialize(items)
            @items = items
            @attributes = @items.first&.to_hash.keys
        end
        
        def to_s()
            @table || format
        end

        def format
            @table ||= "<table>%s</table>" % (header + body + footer)

            return @table
        end

        private

        def header
            template = '<thead><tr>'.concat('<th>%s</th>' * @attributes.count).concat('</tr></thead>')
            
            template % @attributes.map{ |k| k.to_s.split('_').map { |s| s.capitalize }.join(' ') }
        end

        def body
            template = '<tr>'.concat('<td>%s</td>' * @attributes.count).concat('</tr>')

            "<tbody>%s</tbody>" % (@items.map do |item| 
                template % item.to_hash.inject([]) { |acc, (k, v)| acc.push decorate_cell(k, v) }
            end).join()
        end

        def footer
            ''
        end
    end

end
