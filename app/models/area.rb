class Area < ApplicationRecord
  belongs_to :prefecture
  validates :name, presence: true
end
