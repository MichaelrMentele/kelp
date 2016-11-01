class AddSaleToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :discount, :integer
    add_column :businesses, :price, :integer
  end
end
