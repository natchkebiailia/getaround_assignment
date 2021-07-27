class Rental

  def initialize(obj, ls)
    @id = obj['id']
    @car_id = obj['car_id']
    @start_date = Date.parse(obj['start_date'])
    @end_date = Date.parse(obj['end_date'])
    @distance = obj['distance']

    #store reference for global object
    @ls = ls
  end

  def get_id
    @id
  end

  def set_car(car)
    @car = car
  end

  def get_car
    @car
  end

  def calculate_discounted_price
    #number of days between two dates
    duration = (@end_date - @start_date).to_i + 1
    car = @ls.get_car_by_id(@car_id)
    price_per_day = car.get_price_per_day
    total_day_price = 0
    1.upto(duration) do |n|
      coef = 1
      case n
      when 2..4
        coef = 0.9
      when 5..10
        coef = 0.7
      when 10..Inf
        coef = 0.5
      end
      total_day_price += coef * price_per_day
    end
    car_km_price = car.get_km_price
    #return price
    (total_day_price + (car_km_price * @distance)).to_i
  end
end