require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/init'
require_relative 'app_helpers'

class NDTechNetworkApp < Sinatra::Base

  helpers AppHelpers

  register Sinatra::ActiveRecordExtension

  set :root, File.dirname(__FILE__)
  # set :views, Proc.new { File.join(root, "views") }
  set :database_file, "config/database.yml"

  enable :sessions

  get '/' do
    erb :index
  end

  get '/students' do
    @people = Person.where("graduation_class >= ?", current_student_year)
    erb :people_list
  end

  get '/grads' do
    @people = Person.where("graduation_class < ?", current_student_year)
    erb :people_list
  end

  get '/experiences' do
    @experiences = Experience.all
    erb :experience_list
  end

  post '/person' do
    if param[:id]
      p = Person.find(param[:id])
      p.firstname = param[:firstname]
      p.lastname = param[:lastname]
      p.emailnd = param[:emailnd]
      p.emailnonnd = param[:emailnonnd]
      p.graduation_class = param[:graduation_class]
      p.currentcity = param[:currentcity]
      p.save
    else
      Person.create(:firstname => param[:firstname],
                    :lastname => param[:lastname],
                    :emailnd => param[:emailnd],
                    :emailnonnd => param[:emailnonnd],
                    :graduation_class => param[:graduation_class],
                    :currentcity => param[:currentcity])
    end
  end

  post '/experience' do
    if param[:id]
      e = Experience.find(param[:id])
      e.person_id = param[:person_id]
      e.year = param[:graduation_class]
      e.company = param[:company]
      e.is_intern = param[:is_intern]
      e.position_desc = param[:position_desc]
      e.sentiment = param[:sentiment]
      e.save
    else
      Experience.create(:person_id => param[:person_id],
                        :year => param[:graduation_class],
                        :company => param[:company],
                        :is_intern => param[:is_intern],
                        :position_desc => param[:position_desc],
                        :sentiment => param[:sentiment])
    end
  end

end
