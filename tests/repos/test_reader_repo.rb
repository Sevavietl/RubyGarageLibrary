require './lib/library/entities/book.rb'
require './lib/library/entities/reader.rb'
require './lib/library/entities/order.rb'
require './lib/library/repos/reader_repo.rb'
require './lib/library/repos/order_repo.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestReaderRepo < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
    end

    def test_all
        ReaderRepo.all.each { |reader| assert_instance_of(Reader, reader) }
    end

    def test_find
        reader = ReaderRepo.find(1)

        assert_instance_of(Reader, reader)
        assert_equal('John Dow', reader.name)
    end

    def test_get_orders
        reader = ReaderRepo.find(1)
        orders = ReaderRepo.get_orders(reader)
        
        assert_equal(3, orders.size)
    end

    def test_get_books
        reader = ReaderRepo.find(1)
        books = ReaderRepo.get_books(reader)
        
        assert_equal(3, books.size)
    end

    def test_get_books_returns_unique_books
        reader = ReaderRepo.find(1)
        books = ReaderRepo.get_books(reader)

        order = Order.new({ :book_id => books[0].id, :reader_id => reader.id, :date => Time.now.to_i })

        orders = OrderRepo.all

        new_order = OrderRepo.create order

        assert_equal(orders.size + 1, OrderRepo.all.size)
        assert_equal(3, ReaderRepo.get_books(reader).size)

        OrderRepo.delete(new_order)
    end
end
