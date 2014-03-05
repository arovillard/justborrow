class AddRentalsModel < ActiveRecord::Migration
   def change
      add_reference :rentals, :borrower, index: true
      add_column :rentals, :product_id, :integer
      add_column :rentals, :start_date, :timestamp
      add_column :rentals, :end_date, :timestamp
    end
end
