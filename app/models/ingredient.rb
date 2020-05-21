class Ingredient < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  default_scope { self.order :name }
end
