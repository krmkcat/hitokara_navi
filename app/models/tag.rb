class Tag < ApplicationRecord
  has_many :shop_tags
  has_many :review_tags
  has_many :shops, through: :shop_tags, dependent: :destroy
  has_many :reviews, through: :review_tags, dependent: :destroy

  validates :name, presence: true
end
