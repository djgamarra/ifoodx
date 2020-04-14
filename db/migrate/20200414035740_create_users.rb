class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false, default: ''
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :address, null: false
      t.string :phone_number, null: false, default: ''

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
