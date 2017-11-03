require './lib/library/entities/book.rb'
require './lib/library/entities/order.rb'
require './lib/library/entities/reader.rb'
require './lib/library/repos/order_repo.rb'
require './lib/library/repos/book_repo.rb'
require './lib/library/repos/reader_repo.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestOrderRepo < Test::Unit::TestCase
    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/../data/csv/'
    end

    def test_all
        OrderRepo.all.each { |order| assert_instance_of(Order, order) }
    end

    def test_find
        order = OrderRepo.find(1)

        assert_instance_of(Order, order)
        assert_equal(1509655769, order.date)
    end

    def test_get_reader
        order = OrderRepo.find(1)
        
        reader = OrderRepo.get_reader(order)

        assert_instance_of(Reader, reader)
        assert_equal(order.reader_id, reader.id)
    end

    def test_get_book
        order = OrderRepo.find(1)
        
        book = OrderRepo.get_book(order)

        assert_instance_of(Book, book)
        assert_equal(order.book_id, book.id)
    end
end
