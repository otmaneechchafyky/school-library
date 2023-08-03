require 'rspec'
require_relative '../classes/book'
require_relative '../classes/rental'
require_relative '../classes/person'

RSpec.describe Book do
  let(:title) { 'Title 1' }
  let(:author) { 'Youssef' }
  subject(:book) { described_class.new(title, author) }

  describe '#initialize' do
    it 'sets the title and author' do
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
    end

    it 'initializes an empty rentals array' do
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    let(:person1) { Person.new(20, 'Person1') }
    let(:person2) { Person.new(25, 'Person2') }
    let(:rental1) { Rental.new('2023-08-04', book, person1) }
    let(:rental2) { Rental.new('2023-08-05', book, person2) }

    it 'adds rentals to the rentals array' do
      book.add_rental(rental1)
      book.add_rental(rental2)
      expect(book.rentals).to include(rental1, rental2)
    end

    it 'sets the book for the rentals' do
      expect(rental1.book).to eq(book)
      expect(rental2.book).to eq(book)
    end
  end
end
