class ModifyOrderIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_ingredients, :note
    add_column :order_ingredients, :amount, :integer, default: 1
  end
end
