class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(id, age, name = 'Unknown', parent_permission: true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # Name and age setters


  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end

class Student < Person
  attr_reader :classroom
  
  def initialize(classroom, id, age, name = 'Unknown', parent_permission: true)
    super(id, age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    return "¯\(ツ)/¯"
  end
end

ahmed = Student.new("class1", "id01", 17, "otmane", parent_permission: false)

puts ahmed.can_use_services?
puts ahmed.play_hooky