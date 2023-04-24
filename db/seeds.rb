require 'csv'

# #####################################
# ALL
# #####################################
# User creation
puts "Destroying exisitng users..."
User.destroy_all

user = User.new
user.first_name = "Alexandre"
user.last_name = "Stanescot"
user.email = "contact@as-consult.io"
user.role = "admin"
user.password = "contact@as-consult.io"
user.confirmed_at = Time.zone.now - 1.hour
user.confirmation_sent_at = Time.zone.now - 2.hours
if user.save!
  puts "Admin user created"
else
  user.errors.each do | error |
    puts "#{error.full_message}"
  end
  puts "Error in admin user creation"
end

# Import countries
Country.destroy_all
filepath = "ourairports-data/countries.csv"
puts "Reading #{filepath}..."
counter_created = 0
counter_rejected = 0
CSV.foreach(filepath, headers: :first_row) do |row|
  country = Country.create(code: row['code'], name: row['name'], continent: row['continent'])
  country.persisted? ? counter_created += 1 : counter_rejected += 1
end
puts "#{counter_created} / #{counter_created + counter_rejected} countries created!"

# Create some sample weather tiles for demo purpose
puts "Creating weather tiles"
WeatherTile.destroy_all

# Create a factory object with SRID 4326
factory = RGeo::Geographic.spherical_factory(:srid => 4326)

# Iterate on several polygons around luxembourg
(0..8).each do |lon|
  (42..51).each do |lat|

  # Create an array of coordinate pairs
  coordinates = [[lon, lat],
                 [lon, lat + 1],
                 [lon + 1, lat + 1],
                 [lon + 1, lat],
                 [lon, lat]]

  # Create an array of RGeo::Feature::Point objects
  points = coordinates.map { |coord| factory.point(coord[0], coord[1]) }

  # Create a linear ring from the array of points
  ring = factory.linear_ring(points)

  # Create a polygon object from the linear ring
  polygon = factory.polygon(ring)

  # Create a new WeatherTile object with a polygon column
  tile = WeatherTile.new(geom: polygon, lon_center:(lon + (lon + 1)).to_f / 2, lat_center:(lat + (lat + 1)).to_f / 2)

  # Save the object to the database
  tile.save

  end
end


