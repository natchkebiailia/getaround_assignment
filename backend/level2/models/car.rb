class Car

  def initialize(obj, ls)
    @id = obj['id']
    @price_per_day = obj['price_per_day']
    @price_per_km = obj['price_per_km']

    #store reference for global object
    @ls = ls
  end

  def get_id
    @id
  end

  def get_price_per_day
    @price_per_day
  end

  def get_km_price
    @price_per_km
  end
end