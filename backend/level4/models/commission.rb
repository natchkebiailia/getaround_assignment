class Commission

  def initialize(rental)
    @rental_price = rental.calculate_discounted_price
    @total_fees = @rental_price * 0.3
    @insurance_fee = @total_fees * 0.5
    @assistance_fee = 100 * rental.duration
    @drivy_fee = @total_fees - @insurance_fee - @assistance_fee
  end

  def get_pay_actions
    [
      {
        "who" => "driver",
        "type" => "debit",
        "amount" => @rental_price.to_i
      },
      {
        "who" => "owner",
        "type" => "credit",
        "amount" => (@rental_price - @total_fees).to_i
      },
      {
        "who" => "insurance",
        "type" => "credit",
        "amount" => @insurance_fee.to_i
      },
      {
        "who" => "assistance",
        "type" => "credit",
        "amount" => @assistance_fee.to_i
      },
      {
        "who" => "drivy",
        "type" => "credit",
        "amount" => @drivy_fee.to_i
      }
    ]
  end

  def to_json
    {
      "insurance_fee" => @insurance_fee.to_i,
      "assistance_fee" => @assistance_fee.to_i,
      "drivy_fee" => @drivy_fee.to_i,
    }
  end
end  	
