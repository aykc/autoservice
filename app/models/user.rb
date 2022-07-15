class User < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :services, through: :line_items

  validates :name, presence: true
end
