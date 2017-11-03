require_relative '../repos/book_repo.rb'
require_relative '../repos/order_repo.rb'
require_relative '../repos/reader_repo.rb'

require 'set'

class StatisticsService
    class << self
        def book_top_reader(book)
            BookRepo.get_orders(book)
                .inject(Hash.new(0)) { |acc, order| (acc[order.reader_id] += 1) && acc }
                .sort_by{ |id, count| count }
                .to_h.keys.reverse!.each { |id| return ReaderRepo.find(id) }
            
            nil
        end

        def top_popular_books(n = 1)
            books = BookRepo.all

            books.inject(Hash.new(0)) { |acc, book| (acc[book.id] += BookRepo.get_orders(book).size) && acc }
                .sort_by { |id, count| count }
                .to_h.keys.reverse!.map { |id| books.find{ |book| book.id == id } }
                .first(n)
        end

        def top_popular_books_readers_count(n = 1)
            top_popular_books(n).inject(Hash.new) do |acc, book|
                BookRepo.get_orders(book).each do |order|
                    acc[book.id] ||= Set.new
                    acc[book.id].add(order.reader_id) 
                end
                acc
            end
            .inject([]) { |acc, (k, v)| acc.push({ :book_id => k, :readers_count => v.size }) }
        end
    end
end
