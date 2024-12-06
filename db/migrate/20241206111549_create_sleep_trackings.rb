class CreateSleepTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_trackings do |t|
      t.references :user, foreign_key: true, null: false
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.integer :sleep_duration
      t.timestamps
    end
  end
end
