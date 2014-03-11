class AddColunToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :rental_detail, :string
    add_column :rentals, :rental_approved, :boolean
  end
end
