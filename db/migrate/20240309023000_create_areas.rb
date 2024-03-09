class CreateAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :areas do |t|
      t.references :prefecture, null: false, foreign_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
