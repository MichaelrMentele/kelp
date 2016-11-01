class AddVendorRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vendor, :boolean
    add_column :businesses, :owner_id, :integer
  end
end
