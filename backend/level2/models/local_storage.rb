class LocalStorage

  def initialize
    @cars = []
    @rentals = []
  end

  def store_cars(arr)
    arr.each { |car| @cars << Car.new(car, self) }
  end

  def store_rentals(arr)
    arr.each { |rental| @rentals << Rental.new(rental, self) }
  end

  def get_all_rentals
    @rentals
  end

  def get_car_by_id(id)
    @cars.find { |car| car.get_id == id }
  end
end  	
