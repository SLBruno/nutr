class List < ActiveRecord::Base
  belongs_to :user

  has_many :listings
  has_many :recipes, through: :listings

  has_many :ingredients, through: :listings
  ## has_many :recipe_relationships, class_name: "Listing", foreign_key: "recipe_id"
end
