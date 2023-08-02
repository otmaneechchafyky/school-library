require 'json'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative 'rental'
require_relative 'book'
require_relative 'preserve_data'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @data_preserver = Save.new
    load_data_from_files
  end

  def list_all_books
    if @books.empty?
      puts 'There are no books yet, add some please!'
    else
      book_info = @books.map do |book|
        "Title: \"#{book.title}\", Author: \"#{book.author}\""
      end
      puts book_info
    end
  end

  def list_all_people
    if @people.empty?
      puts 'There are no people yet, please add a person!'
    else
      people_info = @people.map do |person|
        "[#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      puts people_info
    end
  end

  def create_a_person(choice, name, age)
    if choice == '1'
      person = create_a_student(name, age)
      person.type = 'Student'
    elsif choice == '2'
      person = create_a_teacher(name, age)
      person.type = 'Teacher'
    else
      puts 'Incorrect input!'
    end
    @people.push(person)
    @data_preserver.save_people(@people)
    puts 'The person created successfully'
  end

  def create_a_book(title, author)
    book = Book.new(title, author)
    @books.push(book)
    @data_preserver.save_books(@books)
    puts 'The Book created successfully'
  end

  def create_a_rental
    puts 'Select a book from the list by number:'
    list_of_books
    index_book = gets.chomp.to_i

    puts 'Select a person from the list by number [not id]:'
    list_of_people
    index_person = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @books[index_book], @people[index_person])
    @rentals.push(rental)
    @data_preserver.save_rentals(@books, @people)
    puts 'The Rental created successfully'
  end

  def list_all_rentals
    puts 'ID: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    if @rentals.empty?
      puts "There are no rentals for #{id}"
    else
      @rentals.each do |rental|
        puts "Date: \"#{rental.date}\", Book: \"#{rental.book.title}\" written by: #{rental.book.author}" if rental.person.id == id
      end
    end
  end

  private

  def create_a_student(name, age)
    print 'Parent permission? [Y/N]: '
    parent_decision = gets.chomp
    print 'Class: '
    label = gets.chomp
    parent_permission = %w[Y y].include?(parent_decision)
    classroom = Classroom.new(label)
    Student.new(classroom, age, name, parent_permission: parent_permission)
  end

  def create_a_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    Teacher.new(specialization, age, name)
  end

  def list_of_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_of_people
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.type}], Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def load_data_from_files
    @people = @data_preserver.read_people
    @books = @data_preserver.read_books
    @rentals = @data_preserver.read_rentals(@books, @people)
  end
end
