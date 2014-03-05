class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :lender, index: true
    add_column :products, :title, :string
    add_column :products, :description, :text
    add_column :products, :price, :decimal, precision: 12, scale: 2
  end
end
