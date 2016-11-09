class AddPortionquantityToListings < ActiveRecord::Migration
  def change
    add_column :listings, :portionquantity, :integer
  end
end
