require 'sinatra/base'
require 'haml'

module Questionnaire
  class App < Sinatra::Base
    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
    end

    get '/' do
      haml :index
    end
  end
end
