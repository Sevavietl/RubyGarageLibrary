require_relative './repo_delegation.rb'

class ReaderRepo
    extend Repo::Delegation

    def self.get_orders(reader)
        OrderRepo.query({ :field => :reader_id, :sign => :==, :value => reader.id })
    end

    def self.get_books(reader)
        books = get_orders(reader).map { |order| BookRepo.find(order.book_id) }
        books.uniq { |book| book.id }
    end
end
