require './lib/library/adapters/in_memory_adapter.rb'

require_relative './adapter_tests.rb'
require_relative './data/in_memory/data.rb'

class TestInMemoryAdapter < Test::Unit::TestCase
    include AdapterTests

    def self.startup
        @@adapter = InMemoryAdapter.new DATA
    end
end
