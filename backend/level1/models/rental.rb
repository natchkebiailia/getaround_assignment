class Rental
  @@rentals = []


  def initialize(obj)
    @id = obj['id']
    @car_id = obj['car_id']
    @start_date = Date.parse(obj['start_date'])
    @end_date = Date.parse(obj['end_date'])
    @distance = obj['distance']
    @car = nil
    @@rentals << self
  end

  def self.create_from_array(arr)
    arr.each { |obj| rental = self.new(obj) }
    self
  end

  def self.match_car(fleet)
    @@rentals.each { |rental| rental.set_car(fleet.find{|car| car.get_id == rental.get_car_id})}
  end  

  def get_id
    @id
  end

  def get_car_id
    @car_id
  end

  def set_car(car)
    @car = car
  end

  def get_car()
    @car
  end

  def calculate_and_get_prices()
    duration = (@end_date-@start_date).to_i+1
    car_daily_price = @car.get_daily_price
    car_km_price = @car.get_km_price
    (car_daily_price * duration) + (car_km_price * @distance)
  end
end