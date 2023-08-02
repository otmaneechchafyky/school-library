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

  def save_rentals(books, people)
    rentals_data = []
    books.each do |book|
      book.rentals.each do |rental|
        person_index = people.index(rental.person)
        rentals_data << { 'date' => rental.date, 'book' => book.title, 'person' => person_index }
      end
    end

    File.write('./json_files/rentals.json', JSON.pretty_generate(rentals_data))
  end

  class Read
    def read_books
      file_path = './json_files/books.json'
      return [] unless File.exist?(file_path)
      books_data = JSON.parse(File.read(file_path))
      books_list = []
      books_data['Books'].each do |book_data|
        books_list << Book.new(book_data['title'], book_data['author'])
      end
      books_list
    end
    def read_people
      file_path = './json_files/people.json'
      return [] unless File.exist?(file_path)
      people_data = JSON.parse(File.read(file_path))
      people_list = []
      classrooms = {}
      # Create and store classrooms first
      people_data['People'].each do |person_data|
        if person_data['type'] == 'Student'
          classroom_label = person_data['classroom_label']
          classrooms[classroom_label] ||= Classroom.new(classroom_label)
        end
        if person_data['type'] == 'Student'
          classroom_label = person_data['classroom_label']
          classroom = classrooms[classroom_label]
          people_list << Student.new(classroom, person_data['age'], person_data['name'],
                                     parent_permission: person_data['parent_permission'])
          else
          people_list << Teacher.new(person_data['specialization'], person_data['age'], person_data['name'])
        end
    end  
  end
  # Create students and teachers with proper classroom objects
  people_list
end

def read_rentals(books, people)
  file_path = './json_files/rentals.json'
  return [] unless File.exist?(file_path)
  rentals_data = JSON.parse(File.read(file_path))
  rentals_list = []
  rentals_data.each do |rental_data|
    book_title = rental_data['book']
    person_index = rental_data['person']
    book = books.find { |b| b.title == book_title }
    person = people[person_index] if person_index
    if book && person
      rental_instance = Rental.new(rental_data['date'], book, person)
      rentals_list << rental_instance
    else
      puts 'Error: Book or person not found'
    end
  end
  rentals_list
end

end
