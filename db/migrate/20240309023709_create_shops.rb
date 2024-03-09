class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone_number
      t.string :url
      t.string :opening_hours
      t.decimal :latitude, precision: 9, scale: 6, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.timestamps
    end

    add_index :shops, [:name, :address], unique: true
  end
end
