class CreateLozengeEntries < ActiveRecord::Migration
  def change
    create_table :lozenge_entries do |t|
      t.integer :entry_id
      t.string :color
      t.integer :slot
      t.integer :day
      t.boolean :lo
      t.boolean :ro
      t.boolean :bo
      t.boolean :to

      t.timestamps
    end
  end
end
