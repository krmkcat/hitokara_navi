class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :password, length: { minimum: 3 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
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
end
