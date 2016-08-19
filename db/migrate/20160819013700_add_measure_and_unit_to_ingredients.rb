class AddMeasureAndUnitToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :unit, :integer
    add_column :ingredients, :measure, :string
  end
end
