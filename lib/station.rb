class Station

  def initialize(name, zone)
    @station_info = {name: name, zone: zone}
  end

  def name
    @station_info[:name]
  end

  def zone
    @station_info[:zone]
  end

end
