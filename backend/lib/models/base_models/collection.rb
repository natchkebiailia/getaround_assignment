class Collection

  include Enumerable

  def initialize
    @items = []
    @model = Item
  end

  def each
    @items.map { |item| yield item }
  end

  def from_array(arr)
    unless arr.nil?
      arr.each { |obj| create_and_add_item(obj) }
    end
    self
  end

  def length
    @items.length
  end

  def all
    @items
  end

  def create_and_add_item(obj)
    item = @model.new(obj)
    add_item(item)
  end

  def add_item(item)
    @items << item
  end

  def add_items(items)
    items.each { |item|
      add_item(item)
    }
    self
  end
end