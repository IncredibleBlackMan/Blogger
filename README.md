# Blogger

[![Maintainability](https://api.codeclimate.com/v1/badges/ece9d83b75e0bc51bf41/maintainability)](https://codeclimate.com/github/Ramon3162/Blogger/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/ece9d83b75e0bc51bf41/test_coverage)](https://codeclimate.com/github/Ramon3162/Blogger/test_coverage) [![Build Status](https://travis-ci.org/Ramon3162/Blogger.svg?branch=develop)](https://travis-ci.org/Ramon3162/Blogger)

This is an Blog API that I use for learning and doing all the stuff I consider as being fun that can fall within this scope.

* Ruby version

This web application is written with Ruby using the Ruby on Rails framework and a PostgreSQL database. You need Ruby version 2.5.3 for the application to work

* Installation

Please make sure you have Ruby(v 2.4.1) and PostgreSQL installed. Take the following steps to setup the application on your local machine:

1. Clone this repository `git clone https://github.com/IncredibleBlackMan/Blogger.git`
2. Run `bundle install` to install all required gems
3. Run `cp config/application.yml.sample config/application.yml` to create the `application.yml` file.

*Note* Update the postgres username and password if you have one
```
POSTGRES_USER: 'your-postgres-username'
POSTGRES_PASSWORD: 'your-postgres-password'
```

* Database creation and configuration

- After creating your `config/application.yml`, you need to create these 2 databases `blogger-database` and `blogger-test-database`. To create them, run:

```
rake db:create
```

