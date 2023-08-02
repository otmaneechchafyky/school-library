
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative 'rental'
require_relative 'book'

class App
  def initialize()
    @people = []
    @books = []
    @rentals = []
  end

  def list_all_books
    if @books.empty?
      puts 'There is no books yet, add some please!'
    else
      book_info = @books.map do |book|
        "Title: \"#{book.title}\", Author: \"#{book.author}\""
      end
    end
    puts book_info
  end

  def list_all_people
    if @people.empty?
      puts 'There is no people yet, please add a person!'
    else
      people_info = @people.map do |person|
        "[#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
    puts people_info
  end

  def create_a_person(choice, name, age)
    if choice == '1'
      person = create_a_student(name, age)
      person.type = 'Student'
    elsif choice == '2'
      person = create_a_teacher(name, age)
      person.type = 'Teacher'
    else
      puts 'Uncorrect inputs!'
    end
    @people.push(person)
    puts 'The person created successfully'
  end

  def create_a_book(title, author)
    book = Book.new(title, author)
    @books.push(book)
    puts 'The Book created successfully'
  end

  def create_a_rental()
    puts '
Select a book from list by number'
    list_of_books
    index_book = gets.chomp.to_i
    puts '
Select a person from list by number [not id]'
    list_of_people
    index_person = gets.chomp.to_i
    print '
Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[index_book], @people[index_person])
    @rentals.push(rental)
    puts 'The Rental created successfully'
  end

  def list_all_rentals
    puts 'ID: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    if @rentals.empty?
      puts "There is no rentals for #{id}"
    else
      @rentals.each do |rental|
        if rental.person.id == id
          puts "Date: \"#{rental.date}\", Book: \"#{rental.book.title}\" wroten by: #{rental.book.author}"
        end
      end
    end
  end

  private

  def create_a_student(name, age)
    print 'Parent permission? [Y/N]: '
    parent_decision = gets.chomp
    print 'Class :'
    label = gets.chomp
    parent_permission = true if %w[Y y].include?(parent_decision)
    parent_permission = false if %w[N n].include?(parent_decision)
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
end
