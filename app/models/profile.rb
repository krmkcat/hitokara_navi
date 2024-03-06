class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :gender, presence: true
  validates :age_group, presence: true

  enum gender: { gender_not_specified: 0, man: 1, woman: 2, other: 3 }
  enum age_group: {
    age_not_specified: 0,
    under_10s: 1,
    in_20s: 2,
    in_30s: 3,
    in_40s: 4,
    in_50s: 5,
    in_60s: 6,
    in_70s: 7,
    over_80s: 8
  }
end
