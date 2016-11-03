class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id, :followable_id
      t.string :followable_type
      t.timestamps
    end
  end
end
