require_relative 'person'

class Student < Person
    attr_reader :classroom
  
    def initialize(classroom, id, age, name = 'Unknown', parent_permission: true)
      super(id, age, name, parent_permission: parent_permission)
      @classroom = classroom
    end
  
    def play_hooky
      '¯(ツ)/¯'
    end
  end