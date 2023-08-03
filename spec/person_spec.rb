require 'rspec'
require_relative '../classes/person'
require_relative '../classes/rental'
require_relative '../classes/book'

RSpec.describe Person do
  let(:age) { 25 }
  let(:name) { 'Otmane' }
  let(:parent_permission) { true }
  subject(:person) { described_class.new(age, name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the age, name, and parent_permission' do
      expect(person.age).to eq(age)
      expect(person.name).to eq(name)
      expect(person.instance_variable_get(:@parent_permission)).to eq(parent_permission)
    end

    it 'initializes an empty rentals array' do
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when person is of age' do
      let(:age) { 20 }

      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is under age with parent permission' do
      let(:age) { 16 }
      let(:parent_permission) { true }

      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is under age without parent permission' do
      let(:age) { 16 }
      let(:parent_permission) { false }

      it 'returns false' do
        expect(person.can_use_services?).to be_falsey
      end
    end
  end

  describe '#add_rental' do
    let(:book) { Book.new('Title1', 'Otmane') }
    let(:rental) { Rental.new('2023', book, person) }

    it 'adds the rental to the rentals array' do
      person.add_rental(rental)
      expect(person.rentals).to include(rental)
    end

    it 'sets the person for the rental' do
      expect(rental.person).to eq(person)
    end
  end
end
