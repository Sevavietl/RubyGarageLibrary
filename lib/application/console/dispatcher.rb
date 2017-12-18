Dir['./lib/library/services/*.rb'].sort.each { |file| require file }

require_relative './form.rb'

class Dispatcher
    attr_accessor :entity_manager, :formater

    def initialize(entity_manager, formater)
        @entity_manager = entity_manager
        @formater = formater
        @validators = {}
    end

    def dispatch(command)
        begin
            case command.strip
                when /^help$/
                    help
                when /^clear$/
                    puts %x{clear}
                when /^exit$/
                    return false
                when /^list ([a-z]+)$/
                    puts @formater.table @entity_manager.get_repo(singularize($1)).all
                when /^show ([a-z]+) ([1-9][0-9]*)$/
                    entity = @entity_manager.find($1, $2.to_i)
                    puts entity ? @formater.item(entity) : "There is no #{$1} with id=#{$2}."
                when /^create ([a-z]+)$/
                    create($1)
                when /^update ([a-z]+) ([1-9][0-9]*)$/
                    update($1, $2)
                when /^top ([1-9][0-9]* )?books?$/
                    puts @formater.table StatisticsService.top_popular_books(($1 || 1).to_i)
                when /^top ([1-9][0-9]* )?books? readers count$/
                    puts @formater.table StatisticsService.top_popular_books_readers_count(($1 || 1).to_i)
                when /^book ([1-9][0-9]*) top reader$/
                    book = BookRepo.find($1.to_i)

                    unless book
                        return (puts "There is no book with id=#{$1}.") || true
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

    def create(subject)
        form = Form.new(@entity_manager.get_entity(subject).new).process
        validator = get_validator(subject).set_inputs(form.to_hash)

        if validator.fails?
            return validator.messages.each { |key, message| puts message } || true
        end

        puts @entity_manager.get_repo(subject).create(form.entity) ? 'Created' : 'Was not created. Try again.'
    end

    def update(subject, id)
        entity = @entity_manager.find(subject, id.to_i)

        unless entity
            return (puts "There is no #{$1} with id=#{$2}.") || true
        end
        
        form = Form.new(entity).process
        validator = get_validator(subject).set_inputs(form.to_hash)

        if validator.fails?
            return validator.messages.each { |key, message| puts message } || true
        end

        puts @entity_manager.get_repo(subject).update(form.entity) ? 'Saved' : 'Was not saved. Try again.'
    end

    def is_integer?(string)
        string.to_i.to_s == string
    end

    def singularize(subject)
        subject.chomp('s')
    end

    def get_validator(subject)
        subject = singularize(subject)

        @validators[subject] ||= @entity_manager.get_validator(subject)&.new
        @validators[subject]
    end

    def help
        puts 'Use `list SUBJECT` to show all items;'
        puts 'Use `show SUBJECT ID` to show the particular item;'
        puts 'Use `create SUBJECT` to create new item;'
        puts 'Use `update SUBJECT ID` to update the particular item;'
        puts 'Use `top [N] book[s]` to list top N books. If no N provided the top book is returned;'
        puts 'Use `top [N] book[s] readers count` to list top N books readers count. If no N provided the top book is returned;'
        puts 'Use `book ID top reader` to show top reader of book;'
        puts 'Use `clear` to clear screen;'
        puts 'Use `exit` to exit program.'
    end
end