require './lib/library/formaters/ascii/table.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestAsciiTable < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../../data/csv/'
    end

    def test_format
        table = AsciiFormater::Table.new BookRepo.all

        string = <<~HEREDOC
        --------------------------------------------------
        |Id|Title                              |Author Id|
        --------------------------------------------------
        |1 |The Jungle Book                    |1        |
        |2 |The Second Jungle Book             |1        |
        |3 |Just So Stories for Little Children|1        |
        |4 |Winnie-the-Pooh                    |2        |
        |5 |The Moomins and the Great Flood    |3        |
        |6 |Comet in Moominland                |3        |
        |7 |Finn Family Moomintroll            |3        |
        |8 |The Exploits of Moominpappa        |3        |
        |9 |Moominsummer Madness               |3        |
        |10|Moominpappa at Sea                 |3        |
        --------------------------------------------------
        HEREDOC

        assert_equal(string, table.format)
        assert_equal(string, table.to_s)
    end
end
