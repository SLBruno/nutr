class AddTimeAndCaloriesToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :calories, :integer
    add_column :recipes, :time, :integer
  end
end
