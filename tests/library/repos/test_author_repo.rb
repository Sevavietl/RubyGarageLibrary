require './lib/library/entities/book.rb'
require './lib/library/entities/author.rb'
require './lib/library/repos/author_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestAuthorRepo < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
    end

    def test_all
        AuthorRepo.all.each { |author| assert_instance_of(Author, author) }
    end

    def test_find
        author = AuthorRepo.find(1)

        assert_instance_of(Author, author)
        assert_equal('Rudyard Kipling', author.name)
    end

    def test_get_books
        kipling = AuthorRepo.find(1)
        milne = AuthorRepo.find(2)
        
        assert_equal(3, AuthorRepo.get_books(kipling).size)
        assert_equal(1, AuthorRepo.get_books(milne).size)
    end
end
