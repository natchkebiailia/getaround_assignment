INPUT_FILE_PATH = './data/input.json'
OUTPUT_FILE_PATH = './data/output.json'
EXPECTED_OUTPUT_FILE_PATH = './data/expected_output.json'

TOTAL_FEE_RATE = 0.3
INSURANCE_FEE_RATE = 0.5
ASSISTANCE_DAILY_FEE = 100
FULL_PRICE_EVERY_DAY = false
MAX_RENTAL_DURATION = Float::INFINITY

DISCOUNT_RULES = [{ 'range' => 0..1, 'coef' => 1 },
                  { 'range' => 2..4, 'coef' => 0.9 },
                  { 'range' => 5..10, 'coef' => 0.7 },
                  { 'range' => 10..MAX_RENTAL_DURATION, 'coef' => 0.5 }]
OPTIONS = {
  'gps' => {
    'daily_price' => 500,
    'belongs_to' => OWNER
  },
  'baby_seat' => {
    'daily_price' => 200,
    'belongs_to' => OWNER
  },
  'additional_insurance' => {
    'daily_price' => 1000,
    'belongs_to' => DRIVY
  }
}