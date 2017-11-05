require './lib/library/formaters/html/table.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestHtmlTable < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../../data/csv/'
    end

    def test_format
        table = HtmlFormater::Table.new BookRepo.all

        string = "<table><thead><tr><th>Id</th><th>Title</th><th>Author Id</th></tr></thead><tbody><tr><td>1</td><td>The Jungle Book</td><td><a href=\"/author/1\">1</a></td></tr><tr><td>2</td><td>The Second Jungle Book</td><td><a href=\"/author/1\">1</a></td></tr><tr><td>3</td><td>Just So Stories for Little Children</td><td><a href=\"/author/1\">1</a></td></tr><tr><td>4</td><td>Winnie-the-Pooh</td><td><a href=\"/author/2\">2</a></td></tr><tr><td>5</td><td>The Moomins and the Great Flood</td><td><a href=\"/author/3\">3</a></td></tr><tr><td>6</td><td>Comet in Moominland</td><td><a href=\"/author/3\">3</a></td></tr><tr><td>7</td><td>Finn Family Moomintroll</td><td><a href=\"/author/3\">3</a></td></tr><tr><td>8</td><td>The Exploits of Moominpappa</td><td><a href=\"/author/3\">3</a></td></tr><tr><td>9</td><td>Moominsummer Madness</td><td><a href=\"/author/3\">3</a></td></tr><tr><td>10</td><td>Moominpappa at Sea</td><td><a href=\"/author/3\">3</a></td></tr></tbody></table>"

        assert_equal(string, table.format)
        assert_equal(string, table.to_s)
    end
end
