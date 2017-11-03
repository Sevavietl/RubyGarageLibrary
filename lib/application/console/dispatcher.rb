Dir['./lib/library/entities/*.rb'].sort.each { |file| require file }
Dir['./lib/library/repos/*.rb'].sort.each { |file| require file }
Dir['./lib/library/services/*.rb'].sort.each { |file| require file }
Dir['./lib/library/validators/*.rb'].sort.each { |file| require file }

require_relative './form.rb'

class Dispatcher
    attr_accessor :formater

    def initialize(formater)
        @formater = formater
        @validators = {}
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

    def create(subject)
        form = Form.new(get_entity(subject).new).process
        validator = get_validator(subject).set_inputs(form.to_hash)

        if validator.fails?
            validator.messages.each { |key, message| puts message }
        else
            puts get_repo(subject).create(form.entity) ? 'Created' : 'Was not created. Try again.'
        end
    end

    def update(subject, id)
        entity = get_repo(subject).find(id.to_i)
        
        if entity
            form = Form.new(entity).process
            validator = get_validator(subject).set_inputs(form.to_hash)

            if validator.fails?
                validator.messages.each { |key, message| puts message }
            else
                puts get_repo(subject).update(form.entity) ? 'Saved' : 'Was not saved. Try again.'
            end
        else
            puts "There is no #{singularize($1)} with id=#{$2}."
        end
    end

    def is_integer?(string)
        string.to_i.to_s == string
    end

    def get_repo(subject)
        Object.const_get("#{singularize(subject).capitalize}Repo")
    end

    def get_entity(subject)
        Object.const_get("#{singularize(subject).capitalize}")
    end

    def get_validator(subject)
        subject = singularize(subject)

        @validators[subject] ||= Object.const_get("#{subject.capitalize}Validator").new
        @validators[subject]
    end

    def singularize(subject)
        subject.chomp('s')
    end

    def help
        puts 'Use `list SUBJECT` to show all items;'
        puts 'Use `show SUBJECT ID` to show the particular item;'
        puts 'Use `create SUBJECT` to create new item;'
        puts 'Use `update SUBJECT ID` to update the particular item;'
        puts 'Use `top [N] books` to list top N books. If no N provided the top book is returned;'
        puts 'Use `exit` to exit program;'
    end
end