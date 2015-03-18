class CreateStationStats < ActiveRecord::Migration
  def change
    create_table :station_stats do |t|
      t.references :station
      t.datetime :statusTime
      t.integer :cb_nbBikes
      t.integer :cb_nbEmptyDocks

      t.timestamps null: false
    end
    add_index :station_stats, :station_id
  end
end
