require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/init'
require_relative 'app_helpers'

class NDTechNetworkApp < Sinatra::Base

  helpers AppHelpers

  register Sinatra::ActiveRecordExtension

  set :root, File.dirname(__FILE__)
  set :database_file, "config/database.yml"

  enable :sessions

  get '/' do
    erb :index
  end

  get '/people/all' do
    @title = "All People"
    @people = Person.all
    erb :people_list
  end

  get '/people/students' do
    @title = "Current Students"
    @people = Person.where("graduation_class >= ?", current_student_year)
    erb :people_list
  end

  get '/people/alumni' do
    @title = "Alumni"
    @people = Person.where("graduation_class < ?", current_student_year)
    erb :people_list
  end

  get %r(/people/([\d]{4})) do |year|
    @title = "Student Search"
    @people = Person.where("graduation_class = ?", year)
    erb :people_list
  end

  get '/experiences' do
    @title = "Experiences"
    @experiences = Experience.all
    erb :experience_list
  end

  get '/experiences/internship' do
    @title = "Internship"
    @experiences = Experience.where("is_intern = 't'")
    erb :experience_list
  end

  get '/experiences/fulltime' do
    @title = "Full Time"
    @experiences = Experience.where("is_intern = 'f'")
    erb :experience_list
  end

  get '/experiences/company/:company' do |company|
    @title = "Company Search"
    @experiences = Experience.where("company like ?", "%#{company}%")
    puts "%#{company}%"
    erb :experience_list
  end

  post '/person' do
    Person.where(:id => param[:id]).first_or_create(
        :firstname => param[:firstname],
        :lastname => param[:lastname],
        :emailnd => param[:emailnd],
        :emailnonnd => param[:emailnonnd],
        :graduation_class => param[:graduation_class],
        :currentcity => param[:currentcity])
  end

  post '/experience' do
    Experience.where(:id => param[:id]).first_or_create(
      :person_id => param[:person_id],
      :year => param[:graduation_class],
      :company => param[:company],
      :is_intern => param[:is_intern],
      :position_desc => param[:position_desc],
      :sentiment => param[:sentiment])
  end

end
