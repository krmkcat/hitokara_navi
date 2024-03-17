User.seed(:email,
  { email: 'admin@test', password: 'password', password_confirmation: 'password', role: :admin },
  { email: 'general1@test', password: 'password', password_confirmation: 'password', role: :general },
  { email: 'general2@test', password: 'password', password_confirmation: 'password', role: :general },
  { email: 'general3@test', password: 'password', password_confirmation: 'password', role: :general },
  { email: 'general4@test', password: 'password', password_confirmation: 'password', role: :general },
  { email: 'general5@test', password: 'password', password_confirmation: 'password', role: :general }
)