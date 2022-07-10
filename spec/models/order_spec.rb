require 'rails_helper'

RSpec.describe Order, type: :model do
  shared_examples_for 'missing attribute' do |attrib|
    let(attrib){ nil }
    it { is_expected.to be_invalid }
  end
  %i[customer_name phone_number email].each do |attrib|
    include_examples 'missing attribute', attrib
  end
end
