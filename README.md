# Odin Facebook API

## Development setup

For local development you will need to install the ruby version listed below

## Require
* Ruby: 3.0
* Rails: ^7.0
* Postgres

## Features

* JWT Authentication
* JSON API Format response

### Setup

Run `bundle install` to get the required dependencies.

Run `bundle exec rails db:drop db:create db:schema:load db:seed migration:reindex:all` to get a fresh database.
Check the `seeds.rb` file for test users.

Run tests with `bundle exec rails spec`.

If all went well, you should see no errors when running `bundle exec rails s`
