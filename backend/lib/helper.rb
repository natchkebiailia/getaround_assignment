DRIVER = "driver"
OWNER = "owner"
DRIVY = "drivy"
ASSISTANCE = "assistance"
INSURANCE = "insurance"

DEBIT = "debit"
CREDIT = "credit"

FEES = {
  INSURANCE => lambda { |total_fees, rental_duration| total_fees * INSURANCE_FEE_RATE },
  ASSISTANCE => lambda { |total_fees, rental_duration| rental_duration * ASSISTANCE_DAILY_FEE },
  DRIVY => lambda { |total_fees, rental_duration| total_fees -
    FEES[INSURANCE].call(total_fees, rental_duration) -
    FEES[ASSISTANCE].call(rental_duration, rental_duration) },
}

def get_price_multiplier_for(nb_day)
  return 1 * nb_day if nb_day <= 1 or FULL_PRICE_EVERY_DAY
  coef = DISCOUNT_RULES.detect { |rule| rule['range'].include?(nb_day) }['coef']
  coef + get_price_multiplier_for(nb_day - 1)
end