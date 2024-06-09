class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :shops, through: :favorites, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :nices
  has_many :nice_reviews, through: :nices, source: 'review', dependent: :destroy

  validates :password, length: { minimum: 8 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] && !external_login? }
  validates :password, presence: true, on: :reset_password
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] && !external_login? }
  validates :email, presence: true, uniqueness: true, unless: -> { external_login? }
  validates :role, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  enum role: { general: 0, admin: 1 }

  def name
    profile.name
  end

  def gender
    profile.gender
  end

  def age_group
    profile.age_group
  end

  def gender_i18n
    profile.gender_i18n
  end

  def age_group_i18n
    profile.age_group_i18n
  end

  def reviewed?(shop)
    reviews.exists?(shop_id: shop.id)
  end

  def own?(object)
    id == object&.user_id
  end

  def profile_displayable?
    !profile.gender_unspecified? || !profile.age_unspecified?
  end

  def display_profile
    if !profile.gender_unspecified? && !profile.age_unspecified?
      "(#{gender_i18n} #{age_group_i18n})"
    elsif profile.gender_unspecified?
      "(#{age_group_i18n})"
    else
      "(#{gender_i18n})"
    end
  end

  def favorite?(shop)
    shop.favorites.pluck(:user_id).include?(id)
  end

  def favorite(shop)
    shops << shop
  end

  def unfavorite(shop)
    shops.delete(shop)
  end

  def nice?(review)
    review.nices.pluck(:user_id).include?(id)
  end

  def nice(review)
    nice_reviews << review
  end

  def unnice(review)
    nice_reviews.delete(review)
  end

  private

  def external_login?
    authentications.any?
  end
end
