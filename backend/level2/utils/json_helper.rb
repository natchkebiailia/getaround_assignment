require 'json'
require 'date'

#global variable infinity
Inf = 1.0 / 0

def get_data(location)
  data = File.read(location)
  JSON.parse(data)
end

def save_data(data_hash, location)
  File.write(location, JSON.pretty_generate(data_hash))
end