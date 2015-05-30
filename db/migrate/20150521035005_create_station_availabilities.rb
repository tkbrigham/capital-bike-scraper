class CreateStationAvailabilities < ActiveRecord::Migration
  def change
    create_table :station_availabilities, id: false do |t|
      t.belongs_to :station, index: true
      t.decimal :average_bikes
      t.decimal :average_docks
      t.integer :day
      t.string :time
    end
  end
end
