namespace :update_user_ranks do
  desc 'すべてのユーザーのユーザーランクを更新する'
  task update_all_users: :environment do
    User.all.each(&:update_rank)
  end
end
