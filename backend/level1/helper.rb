require 'json'
require 'date'

def get_data
  data = File.read('./data/input.json')
  JSON.parse(data)
end

def save_data(data_hash)
  File.write('./data/output.json', JSON.pretty_generate(data_hash))
end