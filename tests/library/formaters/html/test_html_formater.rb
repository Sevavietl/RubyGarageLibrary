require './lib/library/formaters/html/formater.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestHtmlFormater < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../../data/csv/'
        @@formater = HtmlFormater::Formater.new
    end

    def test_table
        table = @@formater.table BookRepo.all

        assert_instance_of(HtmlFormater::Table, table)
    end

    def test_item
        item = @@formater.item BookRepo.find(1)

        assert_instance_of(HtmlFormater::Item, item)
    end
end
