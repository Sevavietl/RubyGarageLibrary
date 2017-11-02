require './lib/library/adapters/csv_adapter.rb'
require './lib/library/entities/book.rb'
require 'test/unit'

class TestCsvAdapter < Test::Unit::TestCase
    def self.startup
        @@adapter = CsvAdapter.new __dir__ + '/data/csv/'
    end

    def test_all
        books = [
            { :id => 1, :title => "The Jungle Book", :author_id => 1},
            { :id => 2, :title => "Winnie-the-Pooh", :author_id => 2}
        ]

        assert_equal(books, @@adapter.all(Book))
    end

    def test_find
        book1 = { :id => 1, :title => "The Jungle Book", :author_id => 1}
        book2 = { :id => 2, :title => "Winnie-the-Pooh", :author_id => 2}

        assert_equal(book1, @@adapter.find(Book, 1))
        assert_equal(book2, @@adapter.find(Book, 2))
    end

    def test_create
        new_book = create_temporary_book

        assert_equal(3, new_book[:id])
        assert_equal(3, @@adapter.all(Book).size)

        remove_temporary_book
    end
    
    def test_update
        new_book = create_temporary_book
        
        new_title = 'The Moomins and the Great Flood';
        
        new_book[:title] = new_title
        
        @@adapter.update(Book, new_book)

        assert_equal(3, @@adapter.all(Book).size)
        assert_equal(new_title, @@adapter.find(Book, 3)[:title])
        
        remove_temporary_book
    end

    def test_delete
        create_temporary_book
        
        assert_equal(3, @@adapter.all(Book).size)
        
        remove_temporary_book
        
        assert_equal(2, @@adapter.all(Book).size)
    end

    def test_query
        books = @@adapter.query(Book, { :field => :author_id, :sign => :==, :value => 2 })

        assert_equal(1, books.size)
        assert_equal(2, books[0][:id])

        create_temporary_book
        
        books = @@adapter.query(Book, { :field => :author_id, :sign => :>=, :value => 2 })

        assert_equal(2, books.size)
        assert_equal(2, books[0][:id])
        assert_equal(3, books[1][:id])

        remove_temporary_book
    end

    private

    def create_temporary_book
        book = Book.new({ :title => "The Moomins", :author_id => 3 })

        new_book = @@adapter.create(book.class, book.to_hash)

        @book = Book.new(new_book)
        
        return new_book
    end

    def remove_temporary_book
        @@adapter.delete(@book.class, @book.to_hash)
    end

end
