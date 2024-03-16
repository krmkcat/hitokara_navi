class Shop < ApplicationRecord
  belongs_to :area
  has_many :reviews, dependent: :destroy
  has_many :shop_tags
  has_many :tags, through: :shop_tags, dependent: :destroy

  validates :area_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :address, presence: true
  validates :url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  with_options presence: true,
               numericality: { greater_than_or_equal_to: -999.999999, less_than_or_equal_to: 999.999999 }, format: { with: /\A-?\d{1,3}(\.\d{1,6})?\z/ } do
    validates :latitude
    validates :longitude
  end

  def reviewed?
    reviews.exists?(user_id: current_user.id)
  end
end
