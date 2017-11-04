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

        string = '<table><thead><tr><th>Id</th><th>Title</th><th>Author Id</th></tr></thead><tbody><tr><th>1</th><th>The Jungle Book</th><th><a href="/author/1">1</a></th></tr><tr><th>2</th><th>The Second Jungle Book</th><th><a href="/author/1">1</a></th></tr><tr><th>3</th><th>Just So Stories for Little Children</th><th><a href="/author/1">1</a></th></tr><tr><th>4</th><th>Winnie-the-Pooh</th><th><a href="/author/2">2</a></th></tr><tr><th>5</th><th>The Moomins and the Great Flood</th><th><a href="/author/3">3</a></th></tr><tr><th>6</th><th>Comet in Moominland</th><th><a href="/author/3">3</a></th></tr><tr><th>7</th><th>Finn Family Moomintroll</th><th><a href="/author/3">3</a></th></tr><tr><th>8</th><th>The Exploits of Moominpappa</th><th><a href="/author/3">3</a></th></tr><tr><th>9</th><th>Moominsummer Madness</th><th><a href="/author/3">3</a></th></tr><tr><th>10</th><th>Moominpappa at Sea</th><th><a href="/author/3">3</a></th></tr></tbody></table>'

        assert_equal(string, table.format)
        assert_equal(string, table.to_s)
    end
end
