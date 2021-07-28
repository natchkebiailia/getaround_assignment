require '../lib/rental_service.rb'
require './config.rb'

#load data from json
input_data = JsonUtilities::load_json(INPUT_FILE_PATH)

#create instances from data
rentals = Rentals.new.from_array(input_data['rentals'])
cars = Cars.new.from_array(input_data['cars'])


rentals.populate_cars(cars)

#do all calculation
rentals.calculate

#create formatted json from result
JsonUtilities::save_data_to_json(rentals.custom_format(['price']), OUTPUT_FILE_PATH)

#check if result is correct
# TODO : remove from here
expected_output = JsonUtilities::load_json(EXPECTED_OUTPUT_FILE_PATH)
output_data = JsonUtilities::load_json(OUTPUT_FILE_PATH)

unless JsonUtilities::compare_json(expected_output, output_data)
  raise "jsons mismatch"
end