require 'json'
require_relative 'app'

class Save
  def save_books(books)
    File.write('./json_files/books.json', JSON.pretty_generate({ 'Books' => books.map do |book|
                                                                              { 'title' => book.title, 'author' => book.author }
                                                                            end }))
  end

  def save_people(people)
    File.write('./json_files/people.json', JSON.pretty_generate({ 'People' => people.map do |person|
                                                                                if person.instance_of?(Student)
                                                                                  { 'type' => person.class, 'age' => person.age, 'name' => person.name,
                                                                                    'parent_permission' => person.parent_permission, 'id' => person.id }
                                                                                else
                                                                                  { 'type' => person.class, 'age' => person.age, 'name' => person.name, 'specialization' => person.specialization,
                                                                                    'id' => person.id }
                                                                                end
                                                                              end }))
  end
end
