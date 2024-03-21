class Prefecture < ApplicationRecord
  has_many :areas, dependent: :destroy
  has_many :shops, through: :areas

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end
end
