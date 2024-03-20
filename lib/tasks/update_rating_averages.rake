namespace :update_rating_averages do
  desc 'すべての店舗のレーティング平均値を更新する'
  task update_all_shops: :environment do
    Shop.all.each(&:update_rating_averages)
  end
end
