require 'rspec'
require_relative '../classes/student'
require_relative '../classes/classroom'

RSpec.describe Student do
  let(:classroom) { Classroom.new('Math Class') }
  let(:age) { 16 }
  let(:name) { 'Otmane' }
  let(:parent_permission) { true }

  subject(:student) { described_class.new(classroom, age, name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the classroom, age, name, and parent_permission' do
      expect(student.classroom).to eq(classroom)
      expect(student.age).to eq(age)
      expect(student.name).to eq(name)
      expect(student.instance_variable_get(:@parent_permission)).to eq(parent_permission)
    end

    it 'initializes an empty rentals array' do
      expect(student.rentals).to be_empty
    end

    it 'adds the student to the classroom' do
      expect(classroom.students).to include(student)
    end
  end

  describe '#can_use_services?' do
    context 'when student is of age' do
      let(:age) { 18 }

      it 'returns true' do
        expect(student.can_use_services?).to be_truthy
      end
    end

    context 'when student is under age with parent permission' do
      let(:age) { 16 }
      let(:parent_permission) { true }

      it 'returns true' do
        expect(student.can_use_services?).to be_truthy
      end
    end

    context 'when student is under age without parent permission' do
      let(:age) { 16 }
      let(:parent_permission) { false }

      it 'returns false' do
        expect(student.can_use_services?).to be_falsey
      end
    end
  end

  describe '#play_hooky' do
    it 'returns a string indicating playing hooky' do
      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end
end
