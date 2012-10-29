class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :week
      t.integer :user_id
      t.integer :year
      t.decimal :hours
      t.integer :activity_id

      t.timestamps
    end
  end
end
