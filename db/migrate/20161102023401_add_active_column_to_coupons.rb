class AddActiveColumnToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :for_sale, :boolean
  end
end
