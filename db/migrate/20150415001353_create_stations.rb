class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :cb_id
      t.string :name
      t.integer :terminal_id
      t.datetime :last_comm_with_server
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :installed
      t.boolean :locked
      t.datetime :install_date
      t.datetime :removal_date
      t.boolean :temporary
      t.boolean :public

      t.timestamps null: false
    end

    add_index :stations, :cb_id
  end
end
