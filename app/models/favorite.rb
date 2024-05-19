class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user_id, presence: true
  validates :shop_id, presence: true
  validates :user_id, uniqueness: { scope: :shop_id }
end
