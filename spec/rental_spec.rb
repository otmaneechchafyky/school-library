require 'rspec'
require_relative '../classes/rental'
require_relative '../classes/book'
require_relative '../classes/person'

RSpec.describe Rental do
  before :each do
    # Create instances of Book and Person
    book = Book.new('Title1', 'Otmane')
    person = Person.new(25, 'Person1', parent_permission: true)

    # Pass the instances to the Rental constructor
    @rental = Rental.new('2023', book, person)
  end

  describe 'Test retrieving data from Rental class' do
    it 'returns the correct Date' do
      expect(@rental.date).to eql '2023'
    end

    it 'returns the correct Book' do
      expect(@rental.book.title).to eql 'Title1'
      expect(@rental.book.author).to eql 'Otmane'
    end

    it 'returns the correct person' do
      expect(@rental.person.name).to eql 'Person1'
      expect(@rental.person.age).to eql 25
    end
  end
end
