class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :following_user, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end

    add_index :followings, %i[user_id following_user_id], unique: true, name: 'user_following_index'
  end
end
