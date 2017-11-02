require_relative './repo_delegation.rb'

class AuthorRepo
    extend Repo::Delegation

    def self.get_books(author)
        BookRepo.query({ :field => :author_id, :sign => :==, :value => author.id })
    end
end
