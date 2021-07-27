require './config.rb'
require './utils/json_utilities.rb'
require './models/commission.rb'
require './models/car.rb'
require './models/fleet'
require './models/rental.rb'
require './models/rentals.rb'

include JsonUtilities

input_data = JsonUtilities::load_json('./data/input.json')


fleet = Fleet.create_from_array(input_data['cars'])
rentals = Rentals.create_from_array(input_data['rentals'])

rentals.populate_cars(fleet)

output_data = {'rentals' => []}
rentals.get_all_rentals.each do |rental|
  output_data['rentals'] << {'id'=>rental.id,
                             'actions'=>Commission.new(rental).get_pay_actions
                            }
end

JsonUtilities::save_data_to_json(output_data, './data/output.json')

#check if result is correct
# TODO : remove from here
expected_output = JsonUtilities::load_json('./data/expected_output.json')
unless JsonUtilities::compare_json(expected_output, output_data)
  raise "jsons mismatch"
end