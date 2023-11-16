# Rails CLI
# Create a new rails app
$ rails new project_name

``
# Start the Rails server
$ rails s
``
# Rails console
$ rails c

# Install dependencies
$ bundle install

# View all routes
$ rails routes

# Toggle rails caching
$ rails dev:cache


# Rails Generator CLI


# Controller (name, action1, action2, ...)
$ rails g controller Products index show

# Model, migration and table columns
$ rails g model Product name:string active:boolean

# Rails Migration
# Rollback last migration
$ rails db:rollback

# Run database seed code
$ rails db:seed

# Delete and re-create db and run migrations
$ rails db:reset

# Create table migration example
```````
create_table :products do |t|
  t.string :name
  t.decimal :price, precision: 8, scale: 2
  t.timestamps
end
```````
# Create table with foreign key
create_table :invoices do |t|
  # null: false = dont allow null value in this db field
  t.references :customer, null: false, foreign_key: true
  t.timestamps
end

# Change table migration example
add_column :invoices, :comment, :text

# to change column name in the table
rails g migration migration_file_name
#after manually change table name in migration file

# CRUD Scaffold (model, migrations, controller, views, test)
rails g scaffold Product name:string price:decimal

# CRUD Scaffold with one to many relationship field
rails g scaffold Invoice customer:references

# Delete scaffold created files
rails destroy scaffold Product

``````
# Routes
``````
# Route maps to controller#action
get 'welcome', to: 'pages#home'

# Root page (root_path name helper)
root 'pages#home'

# Named route
get 'exit', to: 'sessions#destroy', as: :logout

# Create all the routes for a RESTful resource
resources :items

# HTTP    Verb Path    Controller#Action  Named Helper
# GET     /items           items#index    items_path
# GET     /items/new       items#new      new_item_path
# POST    /items           items#create   items_path
# GET     /items/:id       items#show     item_path(:id)
# GET     /items/:id/edit  items#edit     edit_item_path(:id)
# PUT     /items/:id       items#update   item_path(:id)
# DELETE  /items/:id       items#destroy  item_path(:id)

# Only for certain actions
resources :items, only: :index

# Resource with exceptions
resources :items, except: [:new, :create]

# Nested resources
resources :items do
  resources :reviews
end
# create 7 RESTful for items and reviews
# :reviews will have /items/item:id prefixing each routes
# GET /items/:item_id/reviews  reviews#index  item_reviews_path

# Dynamic segment: params['id']
get 'products/:id', to: 'products#show'
# Query String: url /products/1?user_id=2
# params will be {'id' 'user_id'}

# Namespace Admin::ArticleController
# and prefix '/admin'
namespace :admin do
  resources :articles
end

# only prefix '/admin'
scope '/admin' do
  resources :articles, :comments
end

# Redirect
get '/stories', to: redirect('/articles')

`````````
# Model

# Model validation
````````````
validates :title, :description, :image_url, presence: true
validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Must be a valid email address'}
validates :price, numericality: { greater_than_equal_to: 0.01 }
validates :title, uniqueness:  true
validates :title, length: { minimum: 3, maximum: 100 }
validates :type, inclusion: types.keys

# check the validation condition that blocking input submission
review.valid?
review.errors.full_messages

# Model relationship
belongs_to :customer, dependent: :destroy

# Relation with cascade delete
has_many :invoices

#One to one
has_one :profile

# Hook methods
before_destroy :ensure_not_reference_by_any_invoices
before_save :downcase_email

# create virtual password and password_confirmation
# and bcrypt password_digest
# add method to model: user.authenticate(params[:password])
has_secure_password


# Controllers
# Hook before running any code
before_action :set_post, only: [:show, :edit, :update, :destroy]

# If you use Devise (authentification)
before_action :authenticate_user!

# 7 Restfull action short exemple
def index
  # Search input name :q
  if session[:q].present?
    params[:page] = 1
    # Create instance variable @
    @posts = Post.where "title like ?", "%" + session[:q] + "%"
  else
    @posts = Post.all
  end
  @posts = @posts.order("created_at DESC")
  # Pagination with will_paginate gem
  @posts = @posts.paginate(page: params[:page], per_page: 3)
  session[:q] = nil
end

```````
# By convention all action (even empty one)
```````
# run hook before_action and render view template
def show
end

def new
  @post = Post.new
end

def edit
end

def create
  @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Created successfully!'
    else
      render :new
    end
end

def update
  if @post.update(post_params)
      redirect_to @post, notice: 'Updated successfully!'
    else
      render :edit
    end
end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Delete successfully!'
  end

private
  # Use callbacks to share common methods between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :image_url)
  end
end

# render text
render plain: 'Hello User'

```````
# ACTIVE RECORDS
`````````
Article.find(params[:id])
# Do not throw error if not found
Article.find_by(product_id: product_id)
@category = Category.find_by!(slug: params['slug']) # Return Not Found Error (404 page in production)
Article.group(:product_id).sum(:quantity)
Article.where('quantity > 1')
Article.where(cat_id: cat_id, model: model)
Article.where(model: model).or(Article.where(cat_id: cat_id))
Article.join(:categories).where(categories: { id: 2 } )
Article.where("title LIKE ?", "%" + params[:q] + "%")
Article.count
Article.first
Article.last
Article.column_names # ['id', 'name', 'price']
Category.delete_all # delete all rows in Category table
product.category = Category.all.sample # random for Faker data
@products = Product.offset(5).limit(10).all # skip 5, take 10



