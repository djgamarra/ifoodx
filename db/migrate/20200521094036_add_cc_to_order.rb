class AddCcToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :minimum_price, :integer
    add_column :users, :is_admin, :boolean, default: false
  end
end
