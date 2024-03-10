class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop

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

  def self.int_stars
    int_stars = minimal_interactions.map{ |key, _| key }
    int_stars.shift
    int_stars
  end

  def self.eqcust_stars
    int_stars = equipment_customizations.map{ |key, _| key }
    int_stars.shift
    int_stars
  end

  def self.sofr_stars
    int_stars = solo_friendlies.map{ |key, _| key }
    int_stars.shift
    int_stars
  end
end
