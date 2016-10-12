class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name  
      t.string :blurb
      t.string :img_url
      t.text   :synopsis
      t.text   :location 
      t.text   :description 
      t.timestamps
    end
  end
end
