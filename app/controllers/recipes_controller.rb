class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
		@recipe = find_recipe
	end

	def listit
		@recipe = Recipe.find(params[:id])
		@list = List.find(params[:list_id])
		# @listing = @recipe.listings.build({:recipe_id => @recipe.id, :list_id => @list.id }) 
		@listing = Listing.create(:recipe_id => @recipe.id, :list_id => @list.id)
		redirect_to @recipe, notice: "deu certo"	
	end 

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
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
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :measure, :unit, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
