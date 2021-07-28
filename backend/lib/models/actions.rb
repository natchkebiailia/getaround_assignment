class Actions < Collection

  def initialize
    super
    @model = Action
  end

  def apply(who, value)
    action = @items.find { |item| item.who == who }
    action.increase_amount_by(value)
  end

  def get_price
    action = @items.find { |item| item.who == DRIVER }
    action.amount
  end


  def format
    @items.map { |action| { "who" => action.who, "type" => action.type, "amount" => action.amount.to_i } }
  end
end  	
