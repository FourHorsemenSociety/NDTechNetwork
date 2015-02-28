require 'sinatra/base'

class NDTechNetworkApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  enable :sessions

  get '/' do
    "Hello world!"
  end

end
