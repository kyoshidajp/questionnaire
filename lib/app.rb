require 'sinatra/base'
require 'haml'
require 'yaml'

module Questionnaire
  class App < Sinatra::Base
    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
    end

    configure do
      config = YAML.load_file('questionnaire.yml')
      set title: config['title']
      set questions: config['questions']
    end

    get '/' do
      init_default_vals
      haml :index
    end

    post '/' do
      init_default_vals

      haml :close
    end

    private

    def init_default_vals
      @title = settings.title
      @questions = settings.questions.values
    end
  end
end
