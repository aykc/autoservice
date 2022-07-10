require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with a missing name attribute' do
    it 'should be invalid' do
      user = User.new
      expect(user).to be_invalid
    end
  end
end
