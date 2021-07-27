require './helper.rb'
require './models/car.rb'
require './models/rental.rb'


#load json
input_data = get_data
#prepare output
output_data = { 'rentals' => [] }

#initialize instances
fleet = Car.create_from_array(input_data['cars']).all
all_rentals = Rental.create_from_array(input_data['rentals']).match_car(fleet)

#generate output
all_rentals.each do |rental|
  output_data['rentals'] << {
    'id' => rental.get_id,
    'price' => rental.calculate_and_get_prices
  }
end

#save file
save_data(output_data)