class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :service
  belongs_to :user
end
