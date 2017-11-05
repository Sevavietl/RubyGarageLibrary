require './lib/application/web/app.rb'
require 'test/unit'
require 'rack/test'

class HelloWorldTest < Test::Unit::TestCase
    include Rack::Test::Methods

    def self.startup
        Repo.adapter = CsvAdapter.new(__dir__ + '/../../library/data/csv/')        
    end
  
    def app
        Sinatra::Application
    end
  
    def test_home
        get('/')
        
        assert(last_response.body.include?('Please, enjoy the library.'))
    end
  
    def test_it_lists_books
        get('/books')

        assert(last_response.body.include?('<tr><th>Id</th><th>Title</th><th>Author Id</th></tr>'))
    end
    
    def test_it_lists_authors
        get('/authors')

        assert(last_response.body.include?('<tr><th>Id</th><th>Name</th><th>Biography</th></tr>'))
    end

    def test_it_lists_readers
        get('/readers')

        assert(last_response.body.include?('<tr><th>Id</th><th>Name</th><th>Email</th><th>City</th><th>Street</th><th>House</th></tr>'))
    end

    def test_it_lists_orders
        get('/orders')

        assert(last_response.body.include?('<tr><th>Id</th><th>Book Id</th><th>Reader Id</th><th>Date</th></tr>'))
    end

    def test_it_show_author_by_id
        get('/author/1')

        assert(last_response.body.include?('<tr><th>Id</th><td>1</td></tr>'))
        assert(last_response.body.include?('<tr><th>Name</th><td>Rudyard Kipling</td></tr>'))
    end
end
