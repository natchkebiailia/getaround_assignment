require 'json'

module JsonUtilities
  module_function

  def load_json(location)
    begin
      data = File.read(location)
    rescue Errno::ENOENT => e
      LogUtilities::log(__FILE__, e.message)
      #terminate app
      exit -1
    end
    JSON.parse(data)
  end

  def save_data_to_json(data_hash, location)
    File.write(location, JSON.pretty_generate(data_hash))
  end

  # compares two json objects (Array, Hash, or String to be parsed) for equality.
  # Returns true if the objects are equivalent, false otherwise
  # https://gist.github.com/ke4roh/348afe4a793d7d281071
  def compare_json(json1, json2)

    # return false if classes mismatch or don't match our allowed types
    unless (json1.class == json2.class) && (json1.is_a?(String) || json1.is_a?(Hash) || json1.is_a?(Array))
      return false
    end

    # Parse objects to JSON if Strings
    json1, json2 = [json1, json2].map! do |json|
      json.is_a?(String) ? JSON.parse(json) : json
    end
    compare_json0(json1, json2)
  end

  def compare_json0(json1, json2)
    # initializing result var in the desired scope
    result = false

    # If an array, loop through each subarray/hash within the array and recursively call self with these objects for traversal
    if json1.is_a?(Array)
      # Lengths must match
      return false unless (json1.length == json2.length)
      result = true # Zero length is also valid
      json1.each_with_index do |obj, index|
        json1_obj, json2_obj = obj, json2[index]
        result = compare_json0(json1_obj, json2_obj)
        # End loop once a false match has been found
        break unless result
      end
    elsif json1.is_a?(Hash)

      # If a hash, check object1's keys and their values object2's keys and values

      # first check that there are the same number of keys
      return false unless (json1.keys.length == json2.keys.length)

      # created_at and updated_at can create false mismatches due to occasional millisecond differences in tests
      [json1, json2].each { |json| json.delete_if { |key, _| %w[created_at updated_at].include?(key) } }

      json1.each do |key, value|

        # both objects must have a matching key to pass
        return false unless json2.has_key?(key)

        json1_val, json2_val = value, json2[key]

        result = compare_json0(json1_val, json2_val)
        # End loop once a false match has been found
        break unless result
      end
    end

    result ? true : (json1 == json2)
  end
end