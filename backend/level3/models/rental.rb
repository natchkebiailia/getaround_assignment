class Rental

  attr_reader :id, :car_id

  def initialize(obj)
    @id = obj['id']
    @car_id = obj['car_id']
    @start_date = obj['start_date']
    @end_date = obj['end_date']
    @distance = obj['distance']

    @car = nil
  end

  def set_car(car)
    @car = car
  end

  def duration
    (Date.parse(@end_date) - Date.parse(@start_date)).to_i + 1
  end

  def calculate_discounted_price
    price_per_day = @car.price_per_day
    total_day_price = total_coef_price(duration) * price_per_day
    car_km_price = @car.price_per_km
    (total_day_price + (car_km_price * @distance)).to_i
  end

  private

  def total_coef_price(n)
    return 1 if n <= 1
    case n
    when 2..4
      coef = 0.9
    when 5..10
      coef = 0.7
    when 10..INFINITY
      coef = 0.5
    else
      coef = 1
    end
    coef + total_coef_price(n - 1)
  end
end