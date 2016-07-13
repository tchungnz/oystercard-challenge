class Journey

  attr_reader :start, :stop


  #def initialize
  #  @start = nil
  #end

  def entry(entry_station)
    @start = entry_station
  end

  def end(exit_station)
    @stop = exit_station
  end

end
