number_of_users = User.count
number_of_shops = Shop.count

shops = Shop.pluck(:id)

int_keys = Review.minimal_interactions.keys
eqcust_keys = Review.equipment_customizations.keys
sofr_keys = Review.solo_friendlies.keys

number_of_users.times do |n_u|
  random_shops = shops.shuffle
  rand(1..number_of_shops).times do |n_s|
    Review.seed(:user_id, :shop_id) do |s|
      s.user_id = n + 1
      s.shop_id = random_shops.shift
      s.minimal_interaction = int_keys.sample
      s.equipment_customization = eqcust_keys.sample
      s.solo_friendly = sofr_keys.sample
      s.comment = Faker::Lorem.paragraph
    end
  end
end
