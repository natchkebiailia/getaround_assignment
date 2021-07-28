require 'date'

module DateUtilities

  #
  def nb_of_selected_days(start_date_str, end_date_str)
    begin
      start_date = DateTime.strptime(start_date_str, "%Y-%m-%d")
      end_date = DateTime.strptime(end_date_str, "%Y-%m-%d")
    rescue StandardError => e
      LogUtilities::log(__FILE__, e.message)
    end
    #add one day to a date differences
    (end_date - start_date).to_i + 1
  end

end