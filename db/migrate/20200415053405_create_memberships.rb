class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.string :member_type, null: false

      t.timestamps null: false
    end
    add_index :memberships, :user_id, unique: true
  end
end
