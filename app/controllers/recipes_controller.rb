class RecipesController < ApplicationController
	require 'unitwise'
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		## ordena as receitas por tempo de criação
		@recipes = Recipe.all.order("created_at DESC").limit(8)
		@list = List.all.order("created_at DESC")
	end

	def show
		@recipe = find_recipe
	end

	# action para colocar a receita em uma lista 
	def listit
		@recipe = Recipe.find(params[:id])
		@list = List.find(params[:list_id])
		#criar a associação Listing entre receita e lista
		@listing = Listing.create(:recipe_id => @recipe.id, :list_id => @list.id, :portionquantity => 1)
		redirect_to @recipe, notice: "Você salvou uma receita em sua lista"	
	end 


	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)
		if @recipe.save
		#unitwise para converter
			@recipe.ingredients.each do |ingredient|
				if ingredient.measure == "Unidades"
					ingredient.update_attribute(:unitconverted, ingredient.unit )
					ingredient.update_attribute(:measureconverted, "Unidades")
				elsif ingredient.measure == "ml" || "colher de sopa ml"
					@ingredientconverted = Unitwise(ingredient.unit, ingredient.measure).to_ml
					ingredient.update_attribute(:unitconverted, @ingredientconverted.value )
					ingredient.update_attribute(:measureconverted, "ML")
			end
		end
			redirect_to @recipe, notice: "Receita criada!!"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Receita deletada com sucesso"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :measure, :unit, :_destroy, :unitconverted, :measureconverted], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
