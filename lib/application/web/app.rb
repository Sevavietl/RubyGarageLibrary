require 'sinatra'

require './lib/library/adapters/csv_adapter.rb'
require './lib/library/formaters/html/formater.rb'
require './lib/library/entity_manager.rb'

Repo.adapter = CsvAdapter.new(__dir__ + '/../../../data/csv/')

configure do
    set :root, File.dirname(__FILE__)
    set :entity_manager, EntityManager.new
    set :formater, HtmlFormater::Formater.new
end

helpers do
    def list(subject)
        @title = subject.capitalize
        @content = settings.formater.table(settings.entity_manager.get_repo(singularize(subject)).all).format
    
        erb :layout    
    end

    def singularize(subject)
        subject.chomp('s')
    end
end

get '/' do
    @title = 'Home'
    @content = 'Please, enjoy the library.'

    erb :layout
end

get '/books' do
    list('books')
end

get '/authors' do
    list('authors')
end

get '/readers' do
    list('readers')
end

get '/orders' do
    list('orders')
end

get /\/([a-z]+)\/([1-9][0-9]*)/ do
    klass = params['captures'][0]
    id = params['captures'][1].to_i
    entity = settings.entity_manager.find(klass, id)

    return 404 unless entity

    @title = "#{klass.capitalize}(#{id})"
    @content = settings.formater.item entity

    erb :layout
end
