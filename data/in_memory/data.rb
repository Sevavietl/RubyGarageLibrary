DATA = {
    :Author => {
        1 => { :id => 1, :name => 'Rudyard Kipling', :biography => 'an English journalist, short-story writer, poet, and novelist' },
        2 => { :id => 2, :name => 'Alan Alexander Milne', :biography => 'an English author, best known for his books about the teddy bear Winnie-the-Pooh and for various poems' },
        3 => { :id => 3, :name => 'Tove Marika Jansson', :biography => 'a Swedish-speaking Finnish novelist, painter, illustrator and comic strip author' },
    },

    :Book => {
        1 => { :id => 1, :title => 'The Jungle Book', :author_id => 1 },
        2 => { :id => 2, :title => 'The Second Jungle Book', :author_id => 1 },
        3 => { :id => 3, :title => 'Just So Stories for Little Children', :author_id => 1 },
        4 => { :id => 4, :title => 'Winnie-the-Pooh', :author_id => 2 },
        5 => { :id => 5, :title => 'The Moomins and the Great Flood', :author_id => 3 },
        6 => { :id => 6, :title => 'Comet in Moominland', :author_id => 3 },
        7 => { :id => 7, :title => 'Finn Family Moomintroll', :author_id => 3 },
        8 => { :id => 8, :title => 'The Exploits of Moominpappa', :author_id => 3 },
        9 => { :id => 9, :title => 'Moominsummer Madness', :author_id => 3 },
        10 => { :id => 10, :title => 'Moominpappa at Sea', :author_id => 3 },
    },

    :Order => {
        1 => { :id => 1, :book_id => 1, :reader_id => 1, :date => '2017-11-02' },
        2 => { :id => 2, :book_id => 2, :reader_id => 1, :date => '2017-11-02' },
        3 => { :id => 3, :book_id => 4, :reader_id => 2, :date => '2017-11-02' },
        4 => { :id => 4, :book_id => 5, :reader_id => 3, :date => '2017-11-02' },
        5 => { :id => 5, :book_id => 6, :reader_id => 3, :date => '2017-11-02' },
        6 => { :id => 6, :book_id => 7, :reader_id => 3, :date => '2017-11-02' },
        7 => { :id => 7, :book_id => 3, :reader_id => 2, :date => '2017-11-02' },
        8 => { :id => 8, :book_id => 7, :reader_id => 2, :date => '2017-11-02' },
        9 => { :id => 9, :book_id => 8, :reader_id => 1, :date => '2017-11-03' },
        10 => { :id => 10, :book_id => 1, :reader_id => 1, :date => '2017-11-03' },
        11 => { :id => 11, :book_id => 1, :reader_id => 3, :date => '2017-11-03' },
    },

    :Reader => {
        1 => { :id => 1, :name => 'John Dow', :email => 'john@dow.com', :city => 'New York', :street => 'Broadway',  :house => 18 },
        2 => { :id => 2, :name => 'Jane Dow', :email => 'jane@dow.com', :city => 'New York', :street => 'Broadway',  :house => 18 },
        3 => { :id => 3, :name => 'Louie Anderson', :email => 'louie@anderson.com', :city => 'Cedar Knoll', :street => 'AppleStreet',  :house => 8 },
    }
}
