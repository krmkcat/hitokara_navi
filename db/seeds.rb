admin = User.create!(
          email: ENV['ADMIN_EMAIL'],
          password: ENV['ADMIN_PASSWORD'],
          password_confirmation: ENV['ADMIN_PASSWORD'],
          role: :admin
        )

admin.create_profile!(name: 'ななな', gender: :woman, age_group: :in_30s)