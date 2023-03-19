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

