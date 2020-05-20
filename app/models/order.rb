class Order < ApplicationRecord
  belongs_to :user
  has_many :order_ingredients
  has_many :ingredients, through: :order_ingredients
end
