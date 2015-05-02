class CreateStationStats < ActiveRecord::Migration
  def change
    create_table :station_stats do |t|
      t.belongs_to :station, index: true
      t.datetime :scrape_timestamp
      t.datetime :cb_latest_update_time
      t.integer :bikes_available
      t.integer :docks_available

      t.timestamps null: false
    end
  end
end
