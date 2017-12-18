require_relative './repo_delegation.rb'

class BookRepo
    extend Repo::Delegation

    def self.get_author(book)
        AuthorRepo.find(book.author_id)
    end

    def self.get_orders(book)
        OrderRepo.query({ :field => :book_id, :sign => :==, :value => book.id })
    end
end
