require '../lib/rental_service.rb'
require './config.rb'

#load data from json
input_data = JsonUtilities::load_json(INPUT_FILE_PATH)

#create instances from data
rentals = Rentals.new.from_array(input_data['rentals'])
cars = Cars.new.from_array(input_data['cars'])
options = Options.new.from_array(input_data['options'])

rentals.populate_cars(cars)
rentals.set_options(options)

#do all calculation
rentals.calculate

#create formatted json from result
JsonUtilities::save_data_to_json(rentals.format, OUTPUT_FILE_PATH)