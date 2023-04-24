class CreateWeatherTiles < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_tiles do |t|
      t.integer :precision, null: false, default:0
      t.geography :geom, type: "st_polygon", srid: 4326
      t.float :lat_center, null: false, default: 0.00 
      t.float :lon_center, null: false, default: 0.00 

      t.timestamps
    end
  end
end
