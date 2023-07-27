class Rental
  attr_accessor :date, :book, :student

  def initialize(date, book, student)
    @date = date
    @book = book
    @student = student
  end
end
