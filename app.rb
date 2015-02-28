require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/init'

class NDTechNetworkApp < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  set :root, File.dirname(__FILE__)
  set :views, Proc.new { File.join(root, "views") }
  set :database_file, "config/database.yml"

  enable :sessions

  get '/' do
    @people = Person.all
    erb :main_layout, :layout => false do
      erb :hello
    end
  end

  get '/make' do
    Person.create(
      :firstname => "Shuyang",
      :lastname => "Li",
      :graduation_class => "2016",
      :emailnonnd => "shuyang.li.95@gmail.com"
    )
    "Hello world again"
  end

end
