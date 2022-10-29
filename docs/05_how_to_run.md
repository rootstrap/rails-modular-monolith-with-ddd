## 5. How to Run

### Install Ruby 3.0
- Download and install Ruby 3.0 (e.g. with `ruby-install`)

### Install Bundler
- Install Bundler with `gem install bundler`

### Install dependencies
- Run `bundle install` to install dependencies

### Create database
- Install and start PostgreSQL
- Run `bundle exec rails db:create` to create the database
- Run `bundle exec rails db:migrate` to run the migrations

### Start the server
- Run `./bin/dev` to start the server

### Visit the app
- Go to `http://localhost:3000` on your browser to access the server
