class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true, index:

      t.timestamps
    end
    add_index :lists, [:user_id, :created_at]
  end 	
end
