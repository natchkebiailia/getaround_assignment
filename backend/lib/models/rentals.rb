class Rentals < Collection

  def initialize
    super
    @model = Rental
  end

  def calculate
    @items.each do |rental|
      rental.calculate_cashflow
    end
  end

  def populate_cars(cars)
    @items.each { |rental|
      matched_car = cars.all.find { |car| car.id == rental.car_id }
      rental.set_car(matched_car)
    }
  end

  def set_options(options)
    options.all.each { |option|
      matched_rental = @items.find { |rental| rental.id == option.rental_id }
      matched_rental.add_option(option)
    }
  end

  def format
    { "rentals" => @items.map { |rental| { "id" => rental.id, "options" => rental.options.format(), "actions" => rental.actions.format() } } }
  end

  def custom_format(attrs)
    { "rentals" => @items.map do |rental|
      rental_json = { 'id' => rental.id }
      rental_json['actions'] = rental.actions.format() if attrs.include?('actions')
      rental_json['price'] = rental.get_price.to_i if attrs.include?('price')
      rental_json['commission'] = rental.get_commissions_formatted if attrs.include?('commission')
      rental_json
    end
    }
  end

end