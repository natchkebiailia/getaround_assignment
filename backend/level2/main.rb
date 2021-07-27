require './utils/json_helper.rb'
require './models/local_storage.rb'
require './models/car.rb'
require './models/rental.rb'

#read json
input_data = get_data('./data/input.json')

#make global instance
local_storage = LocalStorage.new
#put instances in global instance
local_storage.store_cars(input_data['cars'])
local_storage.store_rentals(input_data['rentals'])

#prepare output
output_data = { 'rentals' => [] }
local_storage.get_all_rentals.each do |rental|
  output_data['rentals'] << { 'id' => rental.get_id,
                              'price' => rental.calculate_discounted_price()
  }
end

#save file
save_data(output_data, './data/output.json')

#check if result is correct
# TODO : remove
expected_output = get_data('./data/expected_output.json')
unless expected_output == output_data
  raise "jsons mismatch"
end