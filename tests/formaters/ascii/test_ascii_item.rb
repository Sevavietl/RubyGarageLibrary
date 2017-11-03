require './lib/library/formaters/ascii/item.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestAsciiItem < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../../data/csv/'
    end

    def test_format
        item = AsciiFormater::Item.new BookRepo.find(1)

        string = <<~HEREDOC
        ---------------------------
        |       Id|              1|
        |    Title|The Jungle Book|
        |Author Id|              1|
        ---------------------------
        HEREDOC

        assert_equal(string, item.format)
        assert_equal(string, item.to_s)
    end
end