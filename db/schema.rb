# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_15_115030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "airports", force: :cascade do |t|
    t.string "icao"
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "iata"
    t.float "latitude"
    t.float "longitude"
    t.integer "altitude"
    t.string "dst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "airport_type"
    t.string "continent"
    t.string "url"
    t.string "local_code"
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "continent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "osm_lines", force: :cascade do |t|
    t.bigint "osm_id", null: false
    t.string "osm_name"
    t.string "amenity", null: false
    t.string "tags"
    t.geometry "way", limit: {:srid=>3857, :type=>"line_string"}
    t.float "distance"
    t.integer "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "osm_points", force: :cascade do |t|
    t.bigint "osm_id", null: false
    t.string "osm_name"
    t.string "amenity", null: false
    t.string "tags"
    t.geometry "way", limit: {:srid=>3857, :type=>"st_point"}
    t.float "distance"
    t.integer "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "geotype"
  end

  create_table "osm_polygones", force: :cascade do |t|
    t.bigint "osm_id", null: false
    t.string "osm_name"
    t.string "amenity", null: false
    t.string "tags"
    t.geometry "way", limit: {:srid=>3857, :type=>"st_polygon"}
    t.float "distance"
    t.integer "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_tiles", force: :cascade do |t|
    t.integer "precision", default: 0, null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_polygon"}
    t.float "lat_center", default: 0.0, null: false
    t.float "lon_center", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
