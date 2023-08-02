require_relative 'classroom'
require_relative 'person'

class Student < Person
  attr_accessor :classroom, :parent_permission

  def initialize(classroom, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    @parent_permission = parent_permission
    classroom.students << self
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
