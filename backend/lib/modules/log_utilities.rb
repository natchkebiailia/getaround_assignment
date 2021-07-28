module LogUtilities
  def log(module_name, message)
    File.open("log.txt", "a") do |f|
      f.write "#{module_name}: #{message}\n"
    end
  end
end