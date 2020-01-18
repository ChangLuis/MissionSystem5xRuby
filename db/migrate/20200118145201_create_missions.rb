class CreateMissions < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :contents, null: false
      t.integer :status, null: false
      t.integer :priority_order, null: false
      t.datetime :initial_time_at, null: false
      t.datetime :finish_time_at, null: false

      t.timestamps
    end
  end
end
