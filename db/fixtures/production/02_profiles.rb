Profile.seed(:user_id,
  {
    user_id: 1,
    name: '管理者',
    gender: :woman,
    age_group: :in_30s,
  },
  {
    user_id: 2,
    name: '一般1',
    gender: :man,
    age_group: :in_40s,
  },
  {
    user_id: 3,
    name: '一般2',
    gender: :gender_unspecified,
    age_group: :in_50s,
  },
  {
    user_id: 4,
    name: '一般3',
    gender: :woman,
    age_group: :in_60s,
  },
  {
    user_id: 5,
    name: '一般4',
    gender: :man,
    age_group: :in_70s,
  },
  {
    user_id: 6,
    name: '一般5',
    gender: :gender_unspecified,
    age_group: :under_10s,
  }
)