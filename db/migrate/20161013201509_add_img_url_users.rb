class AddImgUrlUsers < ActiveRecord::Migration
  def change
    add_column :users, :img_url, :string
    add_column :users, :about, :text
  end
end
