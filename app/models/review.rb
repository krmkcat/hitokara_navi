class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_one :profile, through: :user

  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :shop_id }
  validates :shop_id, presence: true
  with_options presence: true do
    validates :minimal_interaction
    validates :equipment_customization
    validates :solo_friendly
  end
  validates :comment, length: { maximum: 1500 }

  after_save -> { shop.update_rating_averages }
  after_destroy -> { shop.update_rating_averages }

  enum :minimal_interaction, {
    unspecified: 0,
    one_star: 1,
    two_stars: 2,
    three_stars: 3,
    four_stars: 4,
    five_stars: 5
  }, prefix: :int

  enum :equipment_customization, {
    unspecified: 0,
    one_star: 1,
    two_stars: 2,
    three_stars: 3,
    four_stars: 4,
    five_stars: 5
  }, prefix: :eqcust

  enum :solo_friendly, {
    unspecified: 0,
    one_star: 1,
    two_stars: 2,
    three_stars: 3,
    four_stars: 4,
    five_stars: 5
  }, prefix: :sofr

  def self.int_rates
    int_rates = minimal_interactions.keys
    int_rates.shift
    int_rates
  end

  def self.eqcust_rates
    eqcust_rates = equipment_customizations.keys
    eqcust_rates.shift
    eqcust_rates
  end

  def self.sofr_rates
    sofr_rates = solo_friendlies.keys
    sofr_rates.shift
    sofr_rates
  end
end
