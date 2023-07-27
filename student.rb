require_relative 'person'
require_relative 'classroom'
require_relative 'rental'

class Student < Person
  attr_accessor :classroom
  attr_reader :rentals

  def initialize(classroom, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    @rentals = []
  end

  def add_rentals(rental)
    @rentals.push(rental)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
