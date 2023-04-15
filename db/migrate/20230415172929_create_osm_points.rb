class CreateOsmPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :osm_points do |t|
      t.integer :osm_id, null: false
      t.string :osm_name
      t.string :amenity, null: false
      t.string :tags
      t.geography :way, type: "st_point", geographic: true, srid: 4326 #3857 sinon
      t.integer :distance
      t.integer :airport_id

      t.timestamps
    end
  end
end
