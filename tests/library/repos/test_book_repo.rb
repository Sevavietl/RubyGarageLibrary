require './lib/library/entities/book.rb'
require './lib/library/entities/order.rb'
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

    def test_get_orders
        book = BookRepo.find(1)
        orders = BookRepo.get_orders(book)

        assert_equal(3, orders.size)
        orders.each do |order|
            assert_instance_of(Order, order)
        end

        book = BookRepo.find(7)
        orders = BookRepo.get_orders(book)

        assert_equal(2, orders.size)
        orders.each do |order|
            assert_instance_of(Order, order)
        end
    end
end
