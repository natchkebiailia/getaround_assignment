class Options < Collection

  def initialize()
    super
    @model = Option
  end

  def format()
  	@items.map { |option| option.type }
  end	

end