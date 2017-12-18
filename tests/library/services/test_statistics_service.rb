require './lib/library/services/statistics_service.rb'
require './lib/library/entities/book.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestStatisticsService < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
    end

    def test_book_top_reader
        book = BookRepo.find(1)
        reader = StatisticsService.book_top_reader book
        
        assert_instance_of(Reader, reader)
        assert_equal(1, reader.id)
        
        book = BookRepo.find(10)
        reader = StatisticsService.book_top_reader book
        
        assert_equal(nil, reader)
    end

    def test_top_popular_books
        books = StatisticsService.top_popular_books

        assert_equal(1, books.size)
        assert_instance_of(Book, books.first)
        assert_equal(1, books.first.id)
        
        books = StatisticsService.top_popular_books 2

        assert_equal(2, books.size)
        assert_equal(1, books[0].id)
        assert_equal(7, books[1].id)
    end

    def test_top_popular_books_readers_count
        readers_count = StatisticsService.top_popular_books_readers_count

        assert_instance_of(Array, readers_count)
        assert_instance_of(Hash, readers_count.first)
        assert_equal(1, readers_count.size)
        assert_equal(1, readers_count[0][:book_id])
        assert_equal(2, readers_count[0][:readers_count])
    end
end
