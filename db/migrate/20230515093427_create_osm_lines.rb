class CreateOsmLines < ActiveRecord::Migration[7.0]
  def change
    create_table :osm_lines do |t|
      t.integer :osm_id, null: false, :limit => 8
      t.string :osm_name
      t.string :amenity, null: false
      t.string :tags
      t.geography :way, type: "line_string", srid: 3857 #4326
      t.float :distance
      t.integer :airport_id

      t.timestamps
    end
  end
end
