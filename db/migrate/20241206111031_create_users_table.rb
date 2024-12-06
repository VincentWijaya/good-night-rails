class CreateUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users_tables do |t|
      t.string :name,               null: false
      t.string :api_key,            null: false
      t.timestamps
    end

    add_index :users, :api_key, unique: true
  end
end
