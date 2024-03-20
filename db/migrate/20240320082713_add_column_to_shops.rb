class AddColumnToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :int_average, :integer, null: false, default: 0
    add_column :shops, :eqcust_average, :integer, null: false, default: 0
    add_column :shops, :sofr_average, :integer, null: false, default: 0
  end
end
