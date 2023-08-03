require 'rspec'
require_relative '../classes/teacher'

RSpec.describe Teacher do
  let(:specialization) { 'Mathematics' }
  let(:age) { 30 }
  let(:name) { 'Otmane' }

  subject(:teacher) { described_class.new(specialization, age, name) }

  describe '#initialize' do
    it 'sets the specialization, age, and name' do
      expect(teacher.specialization).to eq(specialization)
      expect(teacher.age).to eq(age)
      expect(teacher.name).to eq(name)
    end

    it 'initializes an empty rentals array' do
      expect(teacher.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to be_truthy
    end
  end
end
