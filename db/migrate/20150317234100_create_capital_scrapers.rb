class CreateCapitalScrapers < ActiveRecord::Migration
  def change
    create_table :capital_scrapers do |t|

      t.timestamps null: false
    end
  end
end
