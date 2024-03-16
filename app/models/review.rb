class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_one :profile, through: :user
  has_many :review_tags
  has_many :tags, through: :review_tags, dependent: :destroy

  accepts_nested_attributes_for :review_tags

  validates :user_id, presence: true
  validates :shop_id, presence: true
  with_options presence: true do
    validates :minimal_interaction
    validates :equipment_customization
    validates :solo_friendly
  end
  validates :comment, length: { maximum: 1500 }

  enum minimal_interaction: {
    int_unspecified: 0,
    int_1star: 1,
    int_2stars: 2,
    int_3stars: 3,
    int_4stars: 4,
    int_5stars: 5
  }
  enum equipment_customization: {
    eqcust_unspecified: 0,
    eqcust_1star: 1,
    eqcust_2stars: 2,
    eqcust_3stars: 3,
    eqcust_4stars: 4,
    eqcust_5stars: 5
  }
  enum solo_friendly: {
    sofr_unspecified: 0,
    sofr_1star: 1,
    sofr_2stars: 2,
    sofr_3stars: 3,
    sofr_4stars: 4,
    sofr_5stars: 5
  }

  def self.int_rates
    int_rates = minimal_interactions.map{ |key, _| key }
    int_rates.shift
    int_rates
  end

  def self.eqcust_rates
    eqcust_rates = equipment_customizations.map{ |key, _| key }
    eqcust_rates.shift
    eqcust_rates
  end

  def self.sofr_rates
    sofr_rates = solo_friendlies.map{ |key, _| key }
    sofr_rates.shift
    sofr_rates
  end
end
