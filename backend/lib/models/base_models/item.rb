class Item

  def initialize(obj)
    obj.keys.each do |k|
      self.set_value_for_attribute(k, obj[k])
    end
  end

  def get_value_by_attr(attr)
    instance_variable_get("@#{attr}")
  end

  def set_value_for_attribute(attr, value)
    instance_variable_set("@#{attr}", value)
  end

end