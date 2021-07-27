class Rentals

  def initialize
    @rentals = []
  end

  def self.create_from_array(arr)
    instance = self.new
    arr.each { |rental| instance.add_rental(Rental.new(rental)) }
    instance
  end

  def add_rental(rental)
    @rentals << rental
  end

  def populate_cars(fleet)
    @rentals.each { |rental|
      car_id = rental.car_id
      matched_car = fleet.get_all_cars.find { |car| car.id == car_id }
      rental.set_car(matched_car)
    }
  end

  def get_all_rentals
    @rentals
  end

end