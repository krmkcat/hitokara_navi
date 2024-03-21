class Area < ApplicationRecord
  belongs_to :prefecture
  has_many :shops, dependent: :destroy

  validates :prefecture_id, presence: true
  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end
end
