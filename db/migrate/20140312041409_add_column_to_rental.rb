class AddColumnToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :borrower_acceptance, :boolean
  end
end
