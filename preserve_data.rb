require 'json'
require_relative 'app'

class Save
  def save_books(books)
    File.write('./json_files/books.json', JSON.pretty_generate({ 'Books' => books.map do |book|
                                                                              { 'title' => book.title, 'author' => book.author }
                                                                            end }))
  end
end
