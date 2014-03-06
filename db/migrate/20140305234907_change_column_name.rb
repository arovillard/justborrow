class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :categories, :name, :category_name
  end
end
