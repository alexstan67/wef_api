# README

## INCLUDES

- sassc
- devise
- dotenv-rails
- capistrano

## VERSIONS
- Ruby: 3.1.13
- Rails: 7.0.4.2

## INSTALLATION
* System dependencies

* Configuration

* Database creation
`rails db:create`

* Database initialization
`rails db:migrate`

* Run the database seeds
`rails db:seed`

* How to run the test suite
`rails test`

* Services (job queues, cache servers, search engines, etc.)

## AFTER INSTALLATION
### Envrionment variables

Ensure to have a .env file containing:
````bash
MAIL_USERNAME=noreply
MAIL_PASSWORD=password
MAIL_DOMAIN=example.com
MAIL_SMTP_SERVER=example.com
CONTACT_FORM_RECIPIENT=noreply@example.com
OPENWEATHERMAP_API=xxxxxxxxxxxxxxxxxxxxxx
````

### Create airport data
````bash
# In project folder
git clone git@github.com:davidmegginson/ourairports-data.git
````

## DEPLOYMENT INSTRUCTIONS

## MAINTENANCE
### Update airport data 
````bash
cd ourairports-data
git pull origin main
````

