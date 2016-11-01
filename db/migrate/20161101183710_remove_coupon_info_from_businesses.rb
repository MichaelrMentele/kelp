class RemoveCouponInfoFromBusinesses < ActiveRecord::Migration
  def change
    remove_column :businesses, :price
    remove_column :businesses, :discount
  end
end
