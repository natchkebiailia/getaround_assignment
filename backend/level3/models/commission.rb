class Commission

  def initialize(rental)
    @insurance_fee = total_fees(rental) * 0.5
    @assistance_fee = 100 * rental.duration
    @drivy_fee = total_fees(rental) - @insurance_fee - @assistance_fee
  end

  def increase(val)
    @amount += val
  end

  def to_json
    {
      "insurance_fee" => @insurance_fee.to_i,
      "assistance_fee" => @assistance_fee.to_i,
      "drivy_fee" => @drivy_fee.to_i,
    }
  end

  private
  def total_fees(rental)
    rental.calculate_discounted_price * 0.3
  end
end  	
