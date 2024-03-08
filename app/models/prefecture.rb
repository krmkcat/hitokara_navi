class Prefecture < ApplicationRecord
  has_many :areas, dependent: :destroy
  has_many :shops, through: :areas
  validates :name, presence: true
end
