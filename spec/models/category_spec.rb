require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'with a missing name attribute' do
    it 'should be invalid' do
      category = Category.new
      expect(category).to be_invalid
    end
  end
  context 'with a name attribute' do
    it 'should be valid' do
      expect{ Category.create(name: 'category name') }.to change(Category, :count).by(1)
    end
  end
end
