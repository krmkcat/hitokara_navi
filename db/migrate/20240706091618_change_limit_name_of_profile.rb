class ChangeLimitNameOfProfile < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :name, :string, null: false, limit: 15, default: '名無しのヒトカラー'
  end
end
