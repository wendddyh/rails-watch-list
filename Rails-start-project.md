# start a new rails

```bash
# new project
rails new blog
```

# start [leWagonMini]

```bash
rails new \
  -d postgresql \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/minimal.rb \
  rails-project
```

# Importmap for Rails [leWagonMini]

```bash
bundle add importmap-rails
rails importmap:install
```

# add typical gemfile

```gemfile
gem "bootstrap", "~> 5.2"
gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form"
gem "sassc-rails"
```

# NK adds Gemfile

```gemfile
# additionals
gem 'bootstrap-icons'
gem 'bootstrap-icons-helper'
# gem "font-ionicons-rails" # not compatible
gem "dotenv-rails"
```

# Bootstrap Sequencing after gem
# 1. BOOSTRAP [leWagonMini]

```bash
#add in gemfile
gem "bootstrap", "~> 5.2"
gem 'bootstrap-icons'
#in terminal together with simple form
bundle install
rails generate simple_form:install --bootstrap
# add in /* app/assets/stylesheets/application.scss */
@import "bootstrap";
#test in erb
```

# 2. BOOSTRAP in JS [leWagonMini]

```bash
importmap pin bootstrap
# add in app/javascript/application.js
import "@popperjs/core"
import "bootstrap"
#// app/assets/config/manifest.js
//= link popper.js
//= link bootstrap.min.js
```

# SIMPLE FORM [leWagonMini]

```bash
# add in gemfile
gem "simple_form"
# in bash
bundle install
rails generate simple_form:install --bootstrap
```

# SASSC [leWagonMini]

```bash
# add in gemfile
gem "sassc-rails"
# in bash
bundle install
rm app/assets/stylesheets/application.css
touch app/assets/stylesheets/application.scss
```
# inside app/assets/stylesheets/application.scss

// Graphical variables
@import "config/fonts";
@import "config/colors";
@import "config/bootstrap_variables";

// External libraries
@import "bootstrap";
@import "font-awesome-sprockets";
@import "font-awesome";

// Your CSS partials
@import "components/index";
@import "pages/index";


# FONT AWESOME [leWagonMini]

```bash
# add in Gemfile
gem "font-awesome-sass", "~> 6.1"
# in bash
bundle install
# add in /* app/assets/stylesheets/application.scss */
@import "font-awesome";
```

# AUTOPREFIXER [leWagonMini]

```bash
# in Gemfile
gem "autoprefixer-rails"
# bash
bundle install
```

# LIVERELOAD

```bash
bundle add hotwire-livereload --group development
rails livereload:install
```

# Stimulus Rails
``````
# in gem file
gem 'stimulus-rails'
# terminal
./bin/bundle install.
./bin/rails stimulus:install
``````

# for production via heroku / cloudinary

```gemfile
gem "cloudinary"
```

# DOTENV RAILS

```bash
# Gemfile
gem "dotenv-rails"
# bash
touch .env
cp ../../dotfiles/.gitignore .gitignore
echo '.env*' >> .gitignore

# FONT IONICONS RAILS

```bash
# add Gemfile:
gem "font-ionicons-rails"
# in bash
bundle install
# in application.css.scss
@import "ionicons";
@import ionicons
ion_icon "camera"
```

# Le Wagon’s Stylesheets

```bash
rm -rf app/assets/stylesheets
curl -L https://github.com/lewagon/rails-stylesheets/archive/master.zip > stylesheets.zip
unzip stylesheets.zip -d app/assets && rm -f stylesheets.zip && rm -f app/assets/rails-stylesheets-master/README.md
mv app/assets/rails-stylesheets-master app/assets/stylesheets
curl https://raw.githubusercontent.com/lewagon/fullstack-images/master/lewagon_logo.png > \
  app/assets/images/logo.png
```

In app/assets/stylesheets:
.
├── components
│ ├── \_index.scss # Main components stylesheet
│ ├── \_alert.scss
│ └── \_navbar.scss
├── config
│ ├── \_bootstrap_variables.scss # Bootstrap variables override
│ ├── \_colors.scss # Colors variables 🎨
│ └── \_fonts.scss # Fonts variables ✍️
├── pages
│ ├── \_index.scss # Main pages stylesheet
│ └── \_home.scss
└── application.scss
CSS
Or SCSS
.
└── app
└── assets
└── stylesheets

# Add a new component

```bash
touch app/assets/stylesheets/components/_card.scss
```

Let’s copy the CSS of this card
Then import this component in components/\_index.scss:

```bash
# in file /* app/assets/stylesheets/components/_index.scss */
@import "card";
```

# application.html.erb

# Ionicons

```html
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script  nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
```

# app/asset/stylesheets/application.csss

```css
/* in _incons.scss */
/* Bootstrap Icons */
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css");
/* material Icons */
@import url("https://fonts.googleapis.com/icon?family=Material+Icons");

/* in _fonts.scss */
/*  Google fonts Noto + Noto JP*/
@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100;300;400;500;600;700;800;900&family=Noto+Sans:wght@100;200;300;400;500;600;700;800;900&display=swap");

// Define fonts for body and headers
$body-font: "Noto Sans", "Noto Sans JP", sans-serif;
$headers-font: "Noto Sans", "Noto Sans JP", sans-serif;
```

#test HTML

```html
<div class="container mt-4">
  <h1>Welcome, let's test some settings!</h1>
  <div class="card" style="width: 18rem;">
    <img
      class="card-img-top p-2"
      src="<%= asset_path 'logo.png' %>"
      alt="Card image cap"
    />
    <div class="card-body">
      <h5 class="card-title">Icons</h5>
      <p class="card-text">
        Some quick example text to build on the card title and make up the bulk
        of the card's content.
      </p>
    </div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">
        <ion-icon name="logo-ionic"></ion-icon> Ionicons
      </li>
      <li class="list-group-item">
        <i class="bi bi-bootstrap-fill"></i> Boostrap
      </li>
      <li class="list-group-item">
        <i class="fa-brands fa-font-awesome"></i> Font Awesome
      </li>
    </ul>
    <div class="card-body">
      <a href="#" class="card-link"></a>
      <a href="#" class="card-link"></a>
    </div>
  </div>
</div>
```

# CLOUDINARY

```bash
# Gemfile
gem "cloudinary"
# in bash
bundle install
# .env
CLOUDINARY_URL=cloudinary://298522699261255:***********************8@Qa1ZfO4syfbOC
# upload
curl https://c1.staticflickr.com/3/2889/33773377295_3614b9db80_b.jpg > san_francisco.jpg
curl https://pbs.twimg.com/media/DC1Xyz3XoAAv7zB.jpg > boris_retreat_2017.jpg
# rails c
Cloudinary::Uploader.upload("san_francisco.jpg")
Cloudinary::Uploader.upload("boris_retreat_2017.jpg")
rm san_francisco.jpg boris_retreat_2017.jpg
```

# # # # # # # # # # Starting your application

# rails

# new controller

````bash
rails generate controller Articles index
rails generate model Article title:string body:text
```

# bin/rails routes
resources :filename
```

```bash
rails console
rails server
rails test
rails generate
rails db:migrate
rails db:create
rails routes
rails dbconsole
rails new app_name
```
# modify
```bsh
rails g migration  AddAddressToRestaurants
rails g migration add_city_to_restaurants

... in migration file generated
. add_column
. change_column
. rename_column
. remove_column
. add_reference
```