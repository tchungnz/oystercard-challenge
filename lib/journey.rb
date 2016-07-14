class Journey

  attr_reader :start, :stop, :current_journey

  def initialize
    @current_journey = {}
  end

  def entry(entry_station)
    @start = entry_station
    @current_journey[:start] = entry_station
  end

  def end(exit_station)
    @stop = exit_station
    @current_journey[:stop] = exit_station
  end

  def in_journey?
    !!@start && !@stop
  end

  def fare
    return 1 if !!@start && !!@stop
    return 6
  end

end
