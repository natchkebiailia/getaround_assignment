class Car
  #global variable
  # TODO : remove
  @@fleet = []

  def initialize(obj)
    @id = obj['id']
    @price_per_day = obj['price_per_day']
    @price_per_km = obj['price_per_km']

    @@fleet << self
  end

  def self.create_from_array(arr)
    arr.each { |obj| car = self.new(obj) }
    self
  end

  def self.all
    @@fleet
  end

  def get_id
    @id
  end

  def get_daily_price
    @price_per_day
  end

  def get_km_price
    @price_per_km
  end
end