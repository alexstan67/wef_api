require 'csv'

# ---------------- AIRPORTS -------------------
# ---------------------------------------------
desc "Import airports from csv file"
task airports: :environment do
  puts "Deleting airports entries..."
  filepath = "airports.csv"
  puts "Reading #{filepath}..."
  counter_rejected  = 0
  counter_updated   = 0
  counter_created   = 0

  # First we check if it is a first import
  if Airport.count.zero? # creation mode
    puts "First airport database import..."
    CSV.foreach(filepath, headers: :first_row) do |row|
      airport = Airport.create(icao: row['ident'], name: row['name'], city: row['municipality'], country: row['iso_country'], iata: row['iata_code'], latitude: row['latitude_deg'], longitude: row['longitude_deg'], altitude: row['elevation_ft'], airport_type: row['type'], continent: row['continent'], url: row['home_link'], local_code: row['local_code'])
      airport.persisted? ? counter_created += 1 : counter_rejected += 1
      #puts "#{airport.icao} - #{airport.name} - #{airport.errors.full_messages.join(",")}" if airport.errors.any?
    end
    puts "Imported #{counter_created} / #{counter_created + counter_rejected} airports!"
  else
    puts "Airport database existing..."
    CSV.foreach(filepath, headers: :first_row) do |row|
      current_icao = row['ident']
      if Airport.find_by(icao: row['ident']).nil?
        airport = Airport.create(icao: row['ident'], name: row['name'], city: row['municipality'], country: row['iso_country'], iata: row['iata_code'], latitude: row['latitude_deg'], longitude: row['longitude_deg'], altitude: row['elevation_ft'], airport_type: row['type'], continent: row['continent'], url: row['home_link'], local_code: row['local_code'])
      airport.persisted? ? counter_created += 1 : counter_rejected += 1
      else
        existing_airport  = Airport.find_by(icao: row['ident'])
        csv_airport       = Airport.new(icao: row['ident'], name: row['name'], city: row['municipality'], country: row['iso_country'], iata: row['iata_code'], latitude: row['latitude_deg'], longitude: row['longitude_deg'], altitude: row['elevation_ft'], airport_type: row['type'], continent: row['continent'], url: row['home_link'], local_code: row['local_code'])
        if !existing_airport == csv_airport
          csv_airport.create
          if airport.persisted?
            counter_updated += 1
            puts "Airport #{existing_airport.icao} - #{existing_airport.name} updated"
          else
            counter_rejected += 1
          end
        end
      end
    end
    puts "Imported #{counter_created} / #{counter_created + counter_rejected} airports!"
  end
end
