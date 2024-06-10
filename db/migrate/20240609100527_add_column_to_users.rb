class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rank, :integer, null: false, default: 0
  end
end
