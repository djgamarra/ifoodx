class AddCToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :state, :integer, default: 0
    add_column :orders, :price, :integer, default: 0
  end
end
