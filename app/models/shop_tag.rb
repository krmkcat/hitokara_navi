class ShopTag < ApplicationRecord
  belongs_to :shop
  belongs_to :tag

  validates :shop_id, presence: true
  validates :tag_id, presence: true
end
