require 'rgeo'
require 'rgeo/geo_json'

class MapController < ApplicationController
  def index
    # We load a specific weather polygon
    # We convert rgeo polygon format into GeoJSON
    weatherTile = WeatherTile.last
    @weatherGeoJson = RGeo::GeoJSON.encode(weatherTile.geom).to_json

    # We load 1 airport marker
    airport = Airport.find_by(icao: "ELLX").lonlat
    @airportGeoJson = RGeo::GeoJSON.encode(airport).to_json

    # We load all airports markers
    @airports_array = []
    airports = Airport.all
    airports.each do |airport|
      @airports_array.push({ :name => airport.name,
                            :icao => airport.icao,
                            :geojson => RGeo::GeoJSON.encode(airport.lonlat)
      })
    end 

    #@airportsGeoJson = RGeo::GeoJSON.encode(airports).to_json

  end
end
