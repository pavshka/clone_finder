class Clone
  attr_reader :hash, :locations

  def initialize(hash, locations)
    @hash = hash
    @locations = locations
  end

  def message
    puts hash
    locations.each { |location| puts "    #{location}" }
  end
end
