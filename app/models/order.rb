class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :services, through: :line_items

  validates :customer_name, :phone_number, :email, presence: true

  accepts_nested_attributes_for :line_items
end
