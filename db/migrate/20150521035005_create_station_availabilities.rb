class CreateStationAvailabilities < ActiveRecord::Migration
  def change
    create_table :station_availabilities do |t|
      t.belongs_to :station, index: true
      t.decimal :stations
      t.decimal :docks

      t.timestamps null: false
    end
  end
end
