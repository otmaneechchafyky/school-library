# main.rb
require_relative 'person'
require_relative 'student'
require_relative 'teacher'

# Now you can use the Person, Student, and Teacher classes in this file
student = Student.new('Math101', 'S123', 10, 'John Doe', parent_permission: false)
teacher = Teacher.new('Math', 'T456', 10, 'Jane Smith', parent_permission: false)

p student.can_use_services?
p teacher.can_use_services?