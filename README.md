# Companies on a postcode

This application provides an api to fetch companies available on a postcode.

## API details

```
GET /postal_codes/{postcode}/companies
```

### Example :

Request

```
GET /postal_codes/00100/companies
```

Response

```
[{
	"business_id": "0000000-2",
	"name": "test Oy",
	"postcode": {
		"postcode": "00100",
		"created_at": "2023-03-29T18:09:49.391Z",
		"updated_at": "2023-03-29T18:09:49.391Z"
	},
	"details_uri": "http://avoindata.prh.fi/opendata/bis/v1/3304500-2"
}]
```

## Technical Details

This application uses a cronjob which periodically (every hr) fetches the companyDetails of all the postcodes. This is achieved using [Sidekiq](https://github.com/sidekiq/sidekiq)

This job is also triggerd upon start of the server.

When user makes `GET http://localhost:3000/postal_codes/00200/companies` api call then company details are returned from the database which matches the postcode.

This application uses Ruby 3.1.3p185 with Rails 7.0.4.3

## How to run this app on local

### a. Setup

1. Install `mysql`. This application uses mysql as database.

For mac, run `brew install mysql` to install it.

2. Install `rbenv`

We will use rbenv to setup a virtual ruby env, so that we can avoid conflict/update to system provided ruby. In order to install `rbenv` run on mac

```
brew install rbenv ruby-build
```

More details about `rbenv` can be found [here](https://github.com/rbenv/rbenv)

3. Install `ruby`

Run below to install ruby. More info [here](https://github.com/rbenv/rbenv#installing-ruby-versions)

```
# list latest stable versions:
rbenv install -l

# install a Ruby version:
rbenv install 3.1.3
```

4. Install rails

To install rails, run below

```
gem install rails
```

5. Rehash rails with ruby on rbenv

```
rbenv rehash
```

6. Check Ruby and rails version

```
rails -v   # Rails 7.0.4.3
ruby -v    # ruby 3.1.3p185 (2022-11-24 revision 1a6b16756e) [x86_64-darwin21]
```

7. Install Redis server

For mac run

```
brew install redis
```

### b. Start the application

1. Start mysql with root username and empty password

```
mysql -u root
```

2. Start redis server

```
redis-server
```

3. Install gems

```
bundle install
```

4. Run DB migration

```
rails db:migrate
```

5. Run DB seed, to initiate the database with the postcodes supported. See [db/seeds.rb](db/seeds.rb)

```
rails db:seed
```

6. Start sidekiq worker job. It will fetch the companies details for all the postcodes and save in the database. This job will run every hour. See [config/sidekiq.yml](config/sidekiq.yml)

```
bundle exec sidekiq
```

7. Start rails server

```
rails server
```

The server will start on `3000` port. Upon start open below in browser and see response.

```
http://localhost:3000/postal_codes/00200/companies
```

## How to run the tests

In order to run the tests, switch to test env by running

```
export RAILS_ENV=test
```

then run

```
bundle exec rspec
```
