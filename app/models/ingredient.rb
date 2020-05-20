class Ingredient < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
