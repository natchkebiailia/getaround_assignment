class Rental < Item

  attr_reader :id, :car_id, :start_date, :end_date, :distance, :options, :actions

  def initialize(obj)
    @id = obj['id']
    @car_id = obj['car_id']
    @start_date = obj['start_date']
    @end_date = obj['end_date']
    @distance = obj['distance']

    @car = nil
    @options = Options.new
    @actions = Actions.new.add_items([
                                       Action.new({
                                                    "who" => DRIVER,
                                                    "type" => DEBIT
                                                  }),
                                       Action.new({
                                                    "who" => OWNER,
                                                    "type" => CREDIT
                                                  }),
                                       Action.new({
                                                    "who" => INSURANCE,
                                                    "type" => CREDIT
                                                  }),
                                       Action.new({
                                                    "who" => ASSISTANCE,
                                                    "type" => CREDIT
                                                  }),
                                       Action.new({
                                                    "who" => DRIVY,
                                                    "type" => CREDIT
                                                  })
                                     ])
  end

  def rental_duration
    DateUtilities::nb_of_selected_days(@start_date, @end_date)
  end

  def add_option(option)
    @options.add_item(option)
  end

  def set_car(car)
    @car = car.book(self)
  end

  def calculate_cashflow

    @actions.apply(OWNER, price_without_options - total_fees)

    [INSURANCE, ASSISTANCE, DRIVY].each do |fee|
      @actions.apply(fee, FEES[fee].call(total_fees, rental_duration))
    end

    price_of_options = 0
    unless @options.length === 0
      @options.each do |option|
        price_of_option = option.get_daily_price * rental_duration
        price_of_options += price_of_option
        @actions.apply(option.get_beneficiar, price_of_option)
      end
    end
    @actions.apply(DRIVER, price_without_options + price_of_options)
  end

  def total_fees
    price_without_options * TOTAL_FEE_RATE
  end


  def price_without_options
    price_per_day = @car.price_per_day
    total_day_price = get_price_multiplier_for(rental_duration) * price_per_day
    car_km_price = @car.price_per_km
    (total_day_price + (car_km_price * @distance))
  end

  def get_price
    @actions.get_price
  end

  def get_commissions_formatted
    {
      "insurance_fee": FEES[INSURANCE].call(total_fees, rental_duration).to_i,
      "assistance_fee": FEES[ASSISTANCE].call(total_fees, rental_duration).to_i,
      "drivy_fee": FEES[DRIVY].call(total_fees, rental_duration).to_i
    }
  end

end