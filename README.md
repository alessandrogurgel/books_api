# Book API

This is a simple project to illustrate good Rails practices to implement a REST API.
It contains CRUD endpoints for books and an index endpoint that access a third part API,
Ice And Fire API to retrieve external books.

## Stack and Dependencies
This project uses some open source projects :
- [Rails](http://rubyonrails.org/) - A web-application framework for Ruby. This project currently uses [Rails 5.2.3](http://api.rubyonrails.org/) with the [Ruby 2.7](https://www.ruby-lang.org/en).
- sqlite3
- puma as web server

## Installation
- Check before mentioned links to install Rails and Ruby. I suggest install it via RVM(https://rvm.io/)
- Clone the project source code
- Get into the directory
- Run the command: 'bundle install' for downloading dependencies
- Run the command: 'rake db:migrate' to update the db to the last schema version


## Start Server
- Run the command: 'rails s'
- The service will be started and hosted on localhost por 3000.

## Run Tests
- Run the command: 'RAILS_ENV=test rake db:migrate' to update the test db to the last schema version
TotalPass uses a number of open source projects to work properly:
- Run the command: 'bundle exec rspec' to run all tests. The test results will be displayed on console.

## Contact
Any further questions, feel free to contact me.
- email: alessandrogurgel@gmail.com