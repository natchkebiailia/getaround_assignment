class Car

  attr_reader :id, :price_per_day, :price_per_km

  def initialize(obj)
    @id = obj['id']
    @price_per_day = obj['price_per_day']
    @price_per_km = obj['price_per_km']
  end

end