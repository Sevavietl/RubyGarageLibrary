require './lib/library/adapters/csv_adapter.rb'
require './lib/library/formaters/ascii/formater.rb'
require './lib/library/entity_manager.rb'

require_relative './dispatcher.rb'

class ConsoleApp
    def initialize(config = {})
        Repo.adapter = config[:adapter] || CsvAdapter.new(__dir__ + '/../../../data/csv/')
        @dispatcher = Dispatcher.new(
            config[:entity_manager] || EntityManager.new,
            config[:formater] || AsciiFormater::Formater.new
        )
    end

    def run
        while true do
            print 'Enter the command > '
            break unless @dispatcher.dispatch gets
            puts
        end
    end
end
