require './lib/library/entity_manager.rb'
require './lib/library/adapters/csv_adapter.rb'
require 'test/unit'

class TestEntityManager < Test::Unit::TestCase

    def self.startup
        Repo.adapter = CsvAdapter.new __dir__ + '/data/csv/'
        @@entity_manager = EntityManager.new
    end

    def test_get_entity
        assert_equal(Book, @@entity_manager.get_entity('book'))
        assert_equal(Book, @@entity_manager.get_entity('Book'))
        assert_equal(nil, @@entity_manager.get_entity('Books'))
        assert_equal(nil, @@entity_manager.get_entity('time'))
        assert_equal(nil, @@entity_manager.get_entity('Time'))
    end

    def test_get_repo
        assert_equal(BookRepo, @@entity_manager.get_repo('book'))
        assert_equal(BookRepo, @@entity_manager.get_repo(Book))
        assert_equal(nil, @@entity_manager.get_repo(Time))
        assert_equal(nil, @@entity_manager.get_repo('Time'))
    end
    
    def test_get_validator
        assert_equal(BookValidator, @@entity_manager.get_validator('book'))
        assert_equal(BookValidator, @@entity_manager.get_validator(Book))
        assert_equal(nil, @@entity_manager.get_validator(Time))
        assert_equal(nil, @@entity_manager.get_validator('Time'))
    end

    def test_find
        book = @@entity_manager.find(Book, 1)

        assert_instance_of(Book, book)
        assert_equal(1, book.id)
        
        book = @@entity_manager.find('Book', 1)

        assert_instance_of(Book, book)
        assert_equal(1, book.id)
    end

    def test_get_relations
        assert_equal([Author], @@entity_manager.get_relations(Book))
        assert_equal([Book, Reader], @@entity_manager.get_relations(Order))
        assert_equal([], @@entity_manager.get_relations(Author))
        assert_equal([], @@entity_manager.get_relations(Reader))
    end

    def test_get_relatives
        book = @@entity_manager.find(Book, 1)
        relatives = @@entity_manager.get_relatives(book)

        assert_instance_of(Hash, relatives)
        assert_equal(1, relatives.count)
        assert_instance_of(Author, relatives[Author])
        assert_equal(book.author_id, relatives[Author].id)

        order = @@entity_manager.find(Order, 1)
        relatives = @@entity_manager.get_relatives(order)

        assert_instance_of(Hash, relatives)
        assert_equal(2, relatives.count)
        assert_instance_of(Book, relatives[Book])
        assert_equal(order.book_id, relatives[Book].id)
        assert_instance_of(Reader, relatives[Reader])
        assert_equal(order.reader_id, relatives[Reader].id)
    end

end