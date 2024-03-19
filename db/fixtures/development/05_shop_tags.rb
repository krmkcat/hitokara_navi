number_of_shops = Shop.count
number_of_tags = Tag.count

tags = Tag.pluck(:id)

number_of_shops.times do |n_s|
  random_tags = tags.shuffle
  rand(1..number_of_tags).times do |n_t|
    ShopTag.seed(:shop_id, :tag_id) do |s|
      s.shop_id = n + 1
      s.tag_id = random_tags.shift
    end
  end
end
