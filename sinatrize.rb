# Sinatrize

# usage:
#
# mkdir -p yourapp
# cd yourapp
# wget https://raw.github.com/gist/2385559/sinatrize.rb
# ruby  sinatrize.rb
# rm -f sinatrize.rb
# bundle
# foreman start

# todo:
#
# - add error_404 and 500 pages + not_found and error blocks to have nice error pages (get code from riotvan)


module Capitalize
  def capitalize
    str = self.class? String ? self : self.to_s
    str[0].upcase + str[1..-1]
  end

  def camelcase
    self.split("_").map(&:capitalize).join('')
  end
end

class Pathname
  include Capitalize
end

class String
  include Capitalize
end

## environment

path = File.expand_path ".", __FILE__
require 'pathname'
dirname = Pathname.new(path).dirname.basename
app_name = dirname.to_s
# puts app_name

## configs

dirs = ["config", "coffee", "views", "public", "routes", "sass", "public/css", "log"]

files = [
  { path: "Gemfile",
    contents: <<-CONT
source 'http://rubygems.org'

gem "sinatra"
gem "json"

gem "voidtools"

gem "haml"
gem "sass"

group :development do
  #gem "guard"
  #gem "guard-sass",         require: false
  #gem "guard-coffeescript", require: false
  #gem "guard-livereload",   require: false
end

CONT
  },
  { path: "Readme.md",
    contents: <<-CONT
# #{app_name}

Generated with Sinatrize

tip: find and replace for [...] for meta tags and other useful needed for publication
CONT
  },
  { path: ".gitignore",
    contents: <<-CONT
.sass-cache
*.sql
*.sqlite
CONT
  },
  { path: "config.ru",
    contents: <<-CONT
path = File.expand_path '../', __FILE__

require "\#{path}/#{app_name}"
run #{app_name.camelcase}
CONT
  },
  { path: "#{app_name}.rb",
    contents: <<-CONT
path = File.expand_path '../', __FILE__

require "\#{path}/config/env.rb"

class #{app_name.camelcase} < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  get "/" do
    haml :index
  end
end

require_all "\#{path}/routes"
CONT
  },
  { path: "config/env.rb",
    contents: <<-CONT
path = File.expand_path '../../', __FILE__
APP = "#{app_name}"

require "bundler/setup"
Bundler.require :default
module Utils
  def require_all(path)
    Dir.glob("\#{path}/**/*.rb") do |model|
      require model
    end
  end
end
include Utils

env = ENV["RACK_ENV"] || "development"
# DataMapper.setup :default, "mysql://localhost/#{app_name}_\#{env}"
require_all "\#{path}/models"
# DataMapper.finalize

CONT
  },
  { path: "routes/_main.rb",
    contents: <<-CONT
class #{app_name.camelcase} < Sinatra::Base
  get "/" do
    haml :index
  end
end
CONT
  },
  { path: "views/index.haml",
    contents: <<-CONT
Hello world!
CONT
  },
  { path: "views/layout.haml",
    contents: <<-CONT
!!! 5
%html
  - TITLE = "#{app_name.camelcase}"
  %head
    %title= TITLE
    %link{ rel: "stylesheet", href: "/css/main.css" }
    =# partial :metas

  %body
    #container
      %header
        %h1= TITLE
      %nav
      %section.content= yield
    %script{ type: "text/javascript", src: "/js/app.js" }
CONT
  },
  { path: "views/_metas.haml",
    contents: <<-CONT
%meta{ charset: "utf-8" }
%meta{ :"http-equiv" => "X-UA-Compatible", content: "IE=edge" }
- tagline = "\#{TITLE} - brief description"
- meta_description = "\#{tagline} [...]"
%meta{ name: "description", content: meta_description }
%meta{ name: "keywords", content: "\#{TITLE}, [...]" }
%meta{ name: "author", content: "[...]" }

%meta{ property: "og:title", content: tagline }
%meta{ property: "og:url", content: "http://[...]" }/
%meta{ property: "og:type", content: "website" }/
%meta{ property: "og:site_name", content: TITLE }/
%meta{ property: "og:image", content: "http://[...].png" }/
%meta{ property: "og:description", content: meta_description }/
%meta{ property: "fb:admins", content: "[...]" }/
CONT
  },
  { path: "Guardfile",
    contents: <<-CONT
guard 'sass', input: 'sass', output: 'public/css'
guard 'coffeescript', input: 'coffee', output: "public/js"
guard 'livereload' do
  watch(%r{views/.+\.(erb|haml|slim|md|markdown)})
  watch(%r{public/css/.+\.css})
  watch(%r{public/js/.+\.js})
end
CONT
  },
  { path: "sass/main.sass",
    contents: <<-CONT
body
  background: #EEE
CONT
  },
  { path: "coffee/app.coffee",
    contents: <<-CONT
console.log "hello coffee!"
CONT
  },
]

## code

def create_directories(dirs)
  dirs.each do |dir|
    `mkdir -p #{dir}`
  end
end

create_directories dirs

files.each{ |file| file[:contents].strip! }

files.each do |file|
  File.open(file[:path], "w") do |f|
    f.write file[:contents]
  end
end

# To add:

## scripts:

# create database: mysql -u root -e "CREATE DATABASE #{app_name}_development;"

# run seeds: ruby config/seeds.rb

# auto migrate: ruby -e 'DataMapper.auto_migrate!' -r "./config/env"