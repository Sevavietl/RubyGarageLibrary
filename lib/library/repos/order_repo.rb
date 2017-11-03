require_relative './repo_delegation.rb'

class OrderRepo
    extend Repo::Delegation

    def self.create(order)
        order.date = Time.now.to_i

        super(order)
    end

    def self.get_reader(order)
        ReaderRepo.find(order.reader_id)
    end

    def self.get_book(order)
        BookRepo.find(order.book_id)
    end
end
