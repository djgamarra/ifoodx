class Order < ApplicationRecord
  belongs_to :user
  has_many :order_ingredients, dependent: :destroy
  has_many :ingredients, through: :order_ingredients
  has_many :messages, dependent: :destroy
  scope :admin_order, -> { order('state = 3', :created_at) }
  enum state: {
    'En espera': 0,
    'Aceptado por restaurante': 1,
    'En preparacion': 2,
    'En camino': 3
  }
end
