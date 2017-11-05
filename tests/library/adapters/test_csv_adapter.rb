require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

require_relative './adapter_tests.rb'

class TestCsvAdapter < Test::Unit::TestCase
    include AdapterTests

    def self.startup
        @@adapter = CsvAdapter.new __dir__ + '/data/csv/'
    end
end
