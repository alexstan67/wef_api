# README

## INCLUDES

- sassc
- devise
- dotenv-rails
- capistrano
- rack-cors

## VERSIONS
- Ruby: 3.1.13
- Rails: 7.0.4.2

## ENVIRONMENT VARIABLES
Ensure to have a .env file containing:
````bash
MAIL_USERNAME=noreply
MAIL_PASSWORD=password
MAIL_DOMAIN=example.com
MAIL_SMTP_SERVER=example.com
CONTACT_FORM_RECIPIENT=noreply@example.com
OPENWEATHERMAP_API=xxxxxxxxxxxxxxxxxxxxxx
````

## INSTALLATION
### Gemfile
`bundle install`

### Create airport data
````bash
# In project folder
git clone git@github.com:davidmegginson/ourairports-data.git
````

### Database
````bash
#Database creation
rails db:create

#Database initialization
rails db:migrate

#Run the database seeds
rails db:seed

#Import the airports
rails import:airports

````

## DEPLOYMENT INSTRUCTIONS
TODO

## MAINTENANCE
### Update airports data 
````bash
cd ourairports-data
git pull origin main
````

