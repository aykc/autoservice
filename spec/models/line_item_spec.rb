require 'rails_helper'

RSpec.describe LineItem, type: :model do
  shared_examples_for 'missing attribute' do |attrib|
    let(attrib){ nil }
    it { is_expected.to be_invalid }
  end
  %i[user_id order_id service_id].each do |attrib|
    include_examples 'missing attribute', attrib
  end

  context 'with non-uniq [order_id, service_id]' do
    it 'should not be valid' do
      order = Order.create customer_name: 'name', email: 'email', phone_number: '7777777'
      service = Service.create name: 'service', price: '123', category: Category.create(name: 'cat')
      user = User.create name: 'user'
      LineItem.create order: order, service: service, user: user
      expect { LineItem.create!(order: order, service: service, user: user) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
