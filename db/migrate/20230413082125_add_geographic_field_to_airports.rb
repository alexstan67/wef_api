class AddGeographicFieldToAirports < ActiveRecord::Migration[7.0]
  def change
    add_column :airports, :lonlat, :st_point, geographic: true, srid: 4326
  end
end
