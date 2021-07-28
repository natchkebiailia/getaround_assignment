require 'test/unit'
require '../lib/rental_service.rb'
require './default_config.rb'

class TestExample < Test::Unit::TestCase
  def test_discount_calculation
    #for 0 days
    actual = get_price_multiplier_for(0)
    expected = 0
    assert_equal expected, actual

    #1 day
    actual = get_price_multiplier_for(1)
    expected = 1
    assert_equal expected, actual

    #16 days
    actual = get_price_multiplier_for(17)
    expected = 11.4
    assert_equal expected, actual
  end


end