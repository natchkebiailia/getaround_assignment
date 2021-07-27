class Fleet

  def initialize
    @fleet = []
  end

  def self.create_from_array(arr)
    instance = self.new
    arr.each { |car| instance.add_car(Car.new(car)) }
    instance
  end

  def add_car(car)
    @fleet << car
  end

  def get_all_cars
    @fleet
  end

end