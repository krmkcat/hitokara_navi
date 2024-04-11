admin = User.create!(
          email: ENV['ADMIN_EMAIL'],
          password: 'password',
          password_confirmation: 'password',
          role: :admin
        )

generals = []
20.times do |n|
  generals << User.create!(
                email: "general#{n + 1}@test",
                password: 'password',
                password_confirmation: 'password',
                role: :general
              )
end

admin.create_profile!(name: '管理者', gender: :woman, age_group: :in_30s)

genders = Profile.genders.keys
age_groups = Profile.age_groups.keys

generals.size.times do |n|
  generals[n].create_profile!(
                    name: "一般#{n + 1}",
                    gender: genders.sample,
                    age_group: age_groups.sample
                  )
end