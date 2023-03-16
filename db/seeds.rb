# ALL
# ---------------
# User creation
# Create an admin user
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
