class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :list_id
      t.integer :recipe_id

      t.timestamps
    end
    change_table :listings do |t|
		t.index :list_id
		t.index :recipe_id
		t.index [:list_id, :recipe_id], unique: true
	end 
	end 
end
