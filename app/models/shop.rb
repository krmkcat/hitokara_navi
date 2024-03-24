class Shop < ApplicationRecord
  belongs_to :area
  has_one :prefecture, through: :area
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
  validates :int_average, presence: true, numericality: { in: 0..5 }
  validates :eqcust_average, presence: true, numericality: { in: 0..5 }
  validates :sofr_average, presence: true, numericality: { in: 0..5 }

  scope :by_int_average, ->(int_av) { where('int_average >= ?', int_av) }
  scope :by_eqcust_average, ->(eqcust_av) { where('eqcust_average >= ?', eqcust_av) }
  scope :by_sofr_average, ->(sofr_av) { where('sofr_average >= ?', sofr_av) }
  scope :name_or_address_contain, ->(word) { where('name LIKE ?', "%#{word}%").or(where('address LIKE ?', "%#{word}%")) }
  scope :by_area_id, ->(area_id) { where(area_id: area_id) }
  scope :by_tag_ids, ->(tag_ids) {
    joins(:shop_tags)
      .where(shop_tags: { tag_id: tag_ids })
      .group(:id)
      .having('COUNT(*) = ?', tag_ids.length.to_i)
  }

  def reviewed?
    reviews.exists?(user_id: current_user.id)
  end

  def add_tag(tag)
    tags << tag
  end

  def remove_tag(tag)
    tags.delete(tag)
  end

  def tagged?(tag)
    tags.exists?(id: tag.id)
  end

  def update_rating_averages
    update_average(:minimal_interaction, :int_average, :int_unspecified)
    update_average(:equipment_customization, :eqcust_average, :eqcust_unspecified)
    update_average(:solo_friendly, :sofr_average, :sofr_unspecified)
  end

  def self.average_attributes
    %i[int_average eqcust_average sofr_average]
  end

  def self.averages_select_options
    [['★☆☆☆☆ 以上', 1],
     ['★★☆☆☆ 以上', 2],
     ['★★★☆☆ 以上', 3],
     ['★★★★☆ 以上', 4],
     ['★★★★★', 5]]
  end

  private

  def update_average(review_attr, shop_attr, exclude_attr)
    calculatable_reviews = reviews.where.not(review_attr => exclude_attr)
    new_average = if calculatable_reviews.present?
                    calculatable_reviews.average(review_attr)
                  else
                    0
                  end
    update!(shop_attr => new_average)
  end
end
