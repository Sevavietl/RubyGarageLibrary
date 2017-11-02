require './lib/library/entities/book.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestBookRepo < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
    end

    def test_all
        BookRepo.all.each { |book| assert_instance_of(Book, book) }
    end

    def test_find
        book = BookRepo.find(1)

        assert_instance_of(Book, book)
        assert_equal('The Jungle Book', book.title)
    end

    def test_get_author
        book = BookRepo.find(1)

        author = BookRepo.get_author(book)

        assert_instance_of(Author, author)
        assert_equal(book.author_id, author.id)
    end
end
