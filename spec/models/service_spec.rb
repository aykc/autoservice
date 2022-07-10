require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:name) { 'service name' }
  let(:category) { Category.create(name: 'category') }
  context 'with a missing name attribute' do
    it 'should be invalid' do
      service = Service.new category: category
      expect(service).to be_invalid
    end
  end
  context 'with a missing category attribute' do
    it 'should be invalid' do
      service = Service.new name: name
      expect(service).to be_invalid
    end
  end
end
