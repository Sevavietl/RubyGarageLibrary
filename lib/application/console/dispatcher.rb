Dir['./lib/library/entities/*.rb'].sort.each { |file| require file }
Dir['./lib/library/repos/*.rb'].sort.each { |file| require file }
Dir['./lib/library/services/*.rb'].sort.each { |file| require file }

class Dispatcher
    attr_accessor :formater

    def initialize(formater)
        @formater = formater
    end

    def dispatch(command)
        begin
            case command.strip
                when /^help$/
                    help
                when /^exit$/
                    return false
                when /^list ([a-z]+)$/
                    puts @formater.table get_repo($1).all
                when /^show ([a-z]+) ([1-9][0-9]*)$/
                    entity = get_repo($1).find($2.to_i)
                    puts entity ? @formater.item(entity) : "There is no #{singularize($1)} with id=#{$2}."
                when /^top ([1-9][0-9]* )?books?$/
                    puts @formater.table StatisticsService.top_popular_books(($1 || 1).to_i)
                when /^top ([1-9][0-9]* )?books? readers count$/
                    puts @formater.table StatisticsService.top_popular_books_readers_count(($1 || 1).to_i)
                when /^book ([1-9][0-9]*) top reader$/
                    book = BookRepo.find($1.to_i)

                    unless book
                        puts "There is no book with id=#{$1}."
                        return true
                    end

                    reader = StatisticsService.book_top_reader(book)
                    puts reader ? @formater.item(reader) : "There are no readers for book with id=#{$1}."
                else
                    raise 'Unknown command'
            end
        rescue Exception
            puts 'Cold not proccess your command. Please, try again.'
        end

        true
    end

    private

    def is_integer?(string)
        string.to_i.to_s == string
    end

    def get_repo(subject)
        Object.const_get("#{singularize(subject).capitalize}Repo")
    end

    def singularize(subject)
        subject.chomp('s')
    end

    def help
        puts 'Use `list SUBJECT` to show all items;'
        puts 'Use `show SUBJECT ID` to show particular item;'
        puts 'Use `top [N] books` to list top N books. If no N provided the top book is returned;'
        puts 'Use `exit` to exit program;'
    end
end