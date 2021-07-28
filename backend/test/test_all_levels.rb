require 'test/unit'



class TestAllLevels < Test::Unit::TestCase
  def test_output_for_all_levels
    (1..5).each do |level_number|
      Dir.chdir '../level'+level_number.to_s
      #execute main
      require './main.rb'
      output = JsonUtilities::load_json(OUTPUT_FILE_PATH)
      expected_output = JsonUtilities::load_json(EXPECTED_OUTPUT_FILE_PATH)
      assert_equal JsonUtilities::compare_json(output,expected_output), true
    end

  end


end