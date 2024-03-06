class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, limit: 30, default: '名無しのヒトカラー'
      t.integer :gender, null: false, default: 0
      t.integer :age_group, null: false, default: 0

      t.timestamps
    end
  end
end
