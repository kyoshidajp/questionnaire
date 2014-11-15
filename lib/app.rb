require 'sinatra/base'
require 'sinatra/url_for'
require 'haml'
require 'yaml'

module Questionnaire
  class App < Sinatra::Base

    helpers Sinatra::UrlForHelper

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
    end

    configure do
      config = YAML.load_file('questionnaire.yml')
      set title: config['title']
      set questions: config['questions']
      set result_path: config['result_path']
    end

    get '/' do
      init_default_vals
      haml :index
    end

    post '/' do
      init_default_vals

      if params.values.all? { |v| v == "" }
        @error_string = '回答を入力してください。'
        haml :index
      else
        File.open @result_file, 'a' do |f|
          f.flock File::LOCK_EX
          f.puts YAML.dump(params.merge({'time' => Time.now}))
          f.puts
        end
        haml :close
      end
    end

    private

    def init_default_vals
      @title = settings.title
      @questions = settings.questions.values
      @result_file = settings.result_path + '/result.yml'
    end
  end
end
