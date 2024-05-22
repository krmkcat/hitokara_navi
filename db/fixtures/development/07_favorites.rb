number_of_users = User.count
number_of_shops = Shop.count

shops = Shop.pluck(:id)

number_of_users.times do |n_u|
  random_shops = shops.shuffle
  rand(number_of_shops).times do |n_s|
    Favorite.seed(:user_id, :shop_id) do |s|
      s.user_id = n_u + 1
      s.shop_id = random_shops.shift
    end
  end
end
