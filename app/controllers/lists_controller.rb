class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.where(user_id: current_user.id)
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])
    @listing = Listing.where(list_id: @list.id)
    @recipe = @list.recipes.select(:id)
    @ingredients = @list.ingredients
    consolidate_ingredients
    listmultiplier

end 

  def listmultiplier
    @ming = []
    #pegar cada listing e definir qual é a porção
    @listing.each do |a| 
      porcao = a.portionquantity 
      #abrir cada um dos ingredientes e multiplicar pela porção
      a.ingredients.each do |i|
        unitmultiplied = i.unitconverted * porcao 
        b = [unit: unitmultiplied.to_i, measure: i.measureconverted.to_s, name: i.name.to_s]
        @ming << b
        #salvar em uma array 
      end
      #agrupar pelo name
      #@ming2 = @ming.group_by { |a| 
        #a[:name] }
      end 
    print @ming2

  end 

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'A lista foi criada!' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'A lista foi atualizada!' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'A lista foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :description, :user_id)
    end

    #def multiply_by_portionquantity
      #puxo todas as receitas desta lista
      #@list.recipes.each do |recipe|
        #para cada uma delas, eu descubro qual é a portion_quantity
        #recipe.listings.each do |listing|
        #  @portion = listing.portionquantity
        #end
        #multiplico cada um dos ingredientes pela portion quantity
        #@ingredients_multiplied = recipe.ingredients.each do |ingredient|
        #  ingredient.unitconverted * 2
        #end
      #end
    #end
    def multiply_ingredients

    end

    def consolidate_ingredients
      @ingredientsconsolidated = @ingredients.group(:measureconverted, :name).sum(:unitconverted)
      #SELECT sum(ingredients.unitconverted), measureconverted, name
      #FROM ingredients
      #INNER JOIN recipes ON ingredients.recipe_id = recipe.id
      #INNER JOIN listings ON recipes.id = listings.recipe_id 
      # => WHERE listings.list_id = ?
      
    end
end
