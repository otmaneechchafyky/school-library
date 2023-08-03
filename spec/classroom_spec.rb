require 'rspec'
require_relative '../classes/classroom'
require_relative '../classes/student'

RSpec.describe Classroom do
  let(:label) { 'Math Class' }
  subject(:classroom) { described_class.new(label) }

  describe '#initialize' do
    it 'sets the label' do
      expect(classroom.label).to eq(label)
    end

    it 'initializes an empty students array' do
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_students' do
    let(:student1) { Student.new(classroom, 16, 'Otmane', parent_permission: true) }
    let(:student2) { Student.new(classroom, 17, 'Youssef', parent_permission: false) }

    it 'adds students to the students array' do
      classroom.add_students(student1)
      classroom.add_students(student2)
      expect(classroom.students).to include(student1)
      expect(classroom.students).to include(student2)
    end

    it 'sets the classroom for the students' do
      expect(student1.classroom).to eq(classroom)
      expect(student2.classroom).to eq(classroom)
    end
  end
end
