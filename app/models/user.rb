class User < ApplicationRecord
  has_many :line_items
  has_many :services, through: :line_items

  before_destroy :check_deletion
  validates :name, presence: true

  private
  def check_deletion
    if line_items.any?
      errors.add(:user, 'Нельзя удалить исполнителя, если он присутствует в нарядах') if line_items.any?
      throw :abort
    end
    return true
  end
end
