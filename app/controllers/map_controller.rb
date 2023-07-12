require 'rgeo'
require 'rgeo/geo_json'
require 'rgeo/proj4'

class MapController < ApplicationController
  def index
    # We load a specific weather polygon
    # We convert rgeo polygon format into GeoJSON
    weatherTile = WeatherTile.last
    @weatherGeoJson = RGeo::GeoJSON.encode(weatherTile.geom).to_json

    # We load 1 airport marker
    airport = Airport.find_by(icao: "ELLX").lonlat
    @airportGeoJson = RGeo::GeoJSON.encode(airport).to_json

    # We load 1 airport polygon for test, but SRID is 3857!
    airportPolygon = OsmPolygone.find_by(airport_id: 801)

    #  Define the coordinate system transformation from 3857 to 4326
    source_proj = RGeo::CoordSys::Proj4.create(3857)
    target_proj = RGeo::CoordSys::Proj4.create(4326)
    target_factory = RGeo::Geographic.spherical_factory(srid: 4326)

    # Convert the geometry from 3857 to 4326
    transformed_geometry = RGeo::CoordSys::Proj4.transform(source_proj, airportPolygon.way, target_proj, target_factory)

    # Encode the converted geometry as GeoJSON with SRID 4326
    @airportPolygon = RGeo::GeoJSON.encode(transformed_geometry).to_json

    # We load all airports markers
    @airports_array = []
    airports = Airport.all
    airports.each do |airport|
      @airports_array.push({ :name => airport.name,
                            :icao => airport.icao,
                            :airport_type => airport.airport_type,
                            :geojson => RGeo::GeoJSON.encode(airport.lonlat)
      })
    end 

  end
end
