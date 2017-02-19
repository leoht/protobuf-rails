class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.datetime :venue_date
      t.references :artist, index: true
      t.references :location, index: true

      t.timestamps null: false
    end
    add_foreign_key :venues, :artists
    add_foreign_key :venues, :locations
  end
end
