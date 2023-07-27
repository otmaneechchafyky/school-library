class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rentals(rental)
    @rentals.push(rental)
  end
end

class Rental
  attr_accessor :date, :book

  def initialize(date, book)
    @date = date
    @book = book
  end
end
