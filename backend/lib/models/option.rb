class Option < Item

  attr_reader :id,:rental_id,:type

  def initialize(obj)
    @id = obj['id']
    @rental_id = obj['rental_id']
    @type = obj['type']

  end

  def get_daily_price
  	OPTIONS[@type]['daily_price']
  end

  def get_beneficiar
    OPTIONS[@type]['belongs_to']
  end


end