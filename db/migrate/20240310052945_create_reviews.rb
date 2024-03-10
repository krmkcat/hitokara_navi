class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.integer :minimal_interaction, null: false, default: 3
      t.integer :equipment_customization, null: false, default: 3
      t.integer :solo_friendly, null: false, default: 3
      t.text :comment

      t.timestamps
    end
    add_index :reviews, [:user_id, :shop_id], unique: true
  end
end
