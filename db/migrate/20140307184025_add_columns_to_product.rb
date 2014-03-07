class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :address, :string
    add_column :products, :latitude, :float
    add_column :products, :longitude, :float
  end
end
