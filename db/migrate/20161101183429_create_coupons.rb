class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :user_id, :business_id
      t.integer :discount_percent
      t.integer :price
      t.text :description
      t.timestamps
    end
  end
end
