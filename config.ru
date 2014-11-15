$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'app'
require 'yaml'

conf = YAML.load_file('questionnaire.yml')
relative_path = File.join('/', conf['relative_path']) if conf['relative_path']
map (relative_path || '/') do
  run Questionnaire::App
end
