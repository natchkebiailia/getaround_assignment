require './config.rb'
require './utils/json_utilities.rb'
require './models/commission'
require './models/car.rb'
require './models/rental.rb'

include JsonUtilities

input_data = JsonUtilities::load_json('./data/input.json')

#arrays to hold instances
fleet = []
rentals = []

#create car instances and push in array
input_data['cars'].each do |car|
  fleet << Car.new(car)
end

input_data['rentals'].each do |rental|
  rental = Rental.new(rental)
  car_id = rental.car_id
  #find corresponding car to assign corresponding instance of rental
  matched_car = fleet.find { |car| car.id == car_id }
  rental.set_car(matched_car)
  rentals << rental
end

output_data = { 'rentals' => [] }
rentals.each do |rental|
  output_data['rentals'] << { 'id' => rental.id,
                              'price' => rental.calculate_discounted_price,
                              'commission' => Commission.new(rental).to_json
  }
end

JsonUtilities::save_data_to_json(output_data, './data/output.json')

#check if result is correct
# TODO : remove from here
expected_output = JsonUtilities::load_json('./data/expected_output.json')
unless JsonUtilities::compare_json(expected_output, output_data)
  raise "jsons mismatch"
end