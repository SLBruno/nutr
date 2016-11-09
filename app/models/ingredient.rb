class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  has_many :lists, through: :listings
  has_many :listings, through: :recipe
end
