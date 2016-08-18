class Listing < ActiveRecord::Base
	belongs_to :recipe, class_name: "Recipe"
	belongs_to :list, class_name: "List"
end
