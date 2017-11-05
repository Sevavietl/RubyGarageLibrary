require './lib/library/formaters/html/item.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestHtmlItem < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../../data/csv/'
    end

    def test_format
        item = HtmlFormater::Item.new BookRepo.find(1)

        string = "<table><tbody><tr><th>Id</th><td>1</td></tr><tr><th>Title</th><td>The Jungle Book</td></tr><tr><th>Author Id</th><td><a href=\"/author/1\">1</a></td></tr></tbody></table>"

        assert_equal(string, item.format)
        assert_equal(string, item.to_s)
    end
end
