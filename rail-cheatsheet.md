# FORM

<%# Model form %>
<%= form_with(model: product), local: true do |form| %>
  <%= form.label :title %>
  <%= form.text_field :title, class: 'form-control' %>

  <%= form.submit %>
<% end %>

<%# Generic form %>
<%= form_with url: "/search", method: :get, local: true do |form| %>
  <%= form.label :query, "Search for:" %>
  <%= form.text_field :query, placeholder: 'search' %>
  <%= form.submit "Search", class: 'btn btn-primary' %>
<% end %>

<%# Multi-lines memo %>
<%= form.text_area :description, rows: 10, cols: 60 %>

<%# Collection Select (field, collection, key, value, label) %>
<%= form.collection_select :category_id, Category.all, :id, :name, {include_blank: '- Select a Category -'}, {class: 'form-select'}

<%# Select %>
<%= form.select :type, Customer.types.keys, prompt: 'Select a type' %>
<%= form.select :rating, (1..5) %>

<%# if form in new or edit mode change submit text %>
<%= form.submit @product.new_record? ? 'Create' : 'Update', class: "mt-4 btn btn-primary" %>


# FLASH, SESSION AND COOKIE

# Create flash (reset every new request)
flash[:success] = 'User created with success!'

# Create flash.now (reset every new view render)
flash.now[:error] = 'Please select s user!'

# Create session (reset every browser close)
session[:user_id] = user.id

# Check if session exist
session[:user_id].nil?

# Remove
session.delete(:user_id)

# Remove all
reset_session

# Create cookie (reset at expiration date)
cookies.permanent[:remember_token] = remember_token

# Encrypted cookie
cookies.permanent.encrypted[:user_id] = user.id

# Delete cookie
cookies.delete(:user_id)

# DATABASE SEEDS WITH FAKER

# insert In gem file
$ gem 'faker'

# Run in terminal
bundle install

# db/seeds.rb
Customer.delete_all
(1..10).each do |restaurant|
  @restaurants = Restaurant.create!(name: Faker::Name.name, address: Faker::Address.full_address, phone_number: Faker::PhoneNumber.phone_number, category: %w(chinese italian japanese french belgian).sample )
end

# db seeds via api
require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "http://tmdb.lewagon.com/movie/top_rated"
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
puts "Movies created"

# Run seed script
$ rails db:seed

# DEVISE GEM (AUTHENTICATION)

# Install
gem devise
bundle install
rails g devise:install # follow on-screen instruction
rails generate devise User
rails db:migrate

# Customize devise login, register, etc. views
rails generate devise:views

# Add in existing controllers
before_action :authenticate_user!

# User shared globals
user_signed_in?
current_user

# Logout link_to exemple
<%= link_to "Logout", destroy_user_session_path, method: :delete %>


# HEROKU DEPLOYMENT

# Change Gemfile production database to Postgress
group :development do
 gem 'sqlite3'
end

group :production do
  gem 'pg'
end

# Create git and push to Heroku
$ heroku create
$ git remote
$ bundle install --without production
$ git status
$ git add -A
$ git commit -m 'heroku deployment'
$ git push origin master
$ git push heroku master
$ heroku run rails db:migrate
$ heroku run rails db:seed

# launch the upload site
$ heroku open
