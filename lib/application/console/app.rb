require './lib/library/adapters/csv_adapter.rb'
require './lib/library/formaters/ascii/formater.rb'
require './lib/library/repos/repo.rb'

require_relative './dispatcher.rb'

class ConsoleApp
    def initialize(config = {})
        Repo.adapter = config[:adapter] || CsvAdapter.new(__dir__ + '/../../../data/csv/')
        @dispatcher = Dispatcher.new(config[:formater] || AsciiFormater::Formater.new)
    end

    def run
        while true do
            puts 'Enter the command:'
            break unless @dispatcher.dispatch gets
        end
    end
end
