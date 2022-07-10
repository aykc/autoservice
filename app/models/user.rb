class User < ApplicationRecord
  has_many :line_items
  has_many :services, through: :line_items

  validates :name, presence: true
end
