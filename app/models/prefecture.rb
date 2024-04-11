class Prefecture < ApplicationRecord
  has_many :areas, dependent: :destroy
  has_many :shops, through: :areas

  validates :name, presence: true, uniqueness: true

  scope :selectable, -> { joins(:areas).distinct }

  def self.select_options
    Prefecture.selectable.map { |p| [p.name, prefecture_areas_path(p)] }
  end
end
