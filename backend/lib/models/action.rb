class Action < Item

  attr_reader :who, :type, :amount

  def initialize(obj)
    @who = obj['who']
    @type = obj['type']
    @amount = 0
  end

  def increase_amount_by(val)
    @amount += val
  end

end  	
