class AddUnitconversionAndMeasureconversionToIngredient < ActiveRecord::Migration
  def change
  	# adição das variáveis que vão servir para eu colocar o unitwise
    add_column :ingredients, :unitconverted, :integer
    add_column :ingredients, :measureconverted, :string
  end
end
