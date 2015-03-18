class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :cb_id
      t.string :cb_name
      t.integer :cb_terminalName
      t.datetime :cb_lastCommWithServer
      t.decimal :cb_lat
      t.decimal :cb_long
      t.boolean :cb_installed
      t.boolean :cb_locked
      t.datetime :cb_installDate
      t.datetime :cb_removalDate
      t.boolean :cb_temporary
      t.boolean :cb_public

      t.timestamps null: false
    end
  end
end
