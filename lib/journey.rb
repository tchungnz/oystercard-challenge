class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

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
    return calculate_fare if !!@start && !!@stop
    return PENALTY_FARE
  end

private

  def zone_crossed
    @zones = (@current_journey[:start].zone - @current_journey[:stop].zone).abs
  end

  def calculate_fare
    zone_crossed
    MINIMUM_FARE + @zones
  end

end
