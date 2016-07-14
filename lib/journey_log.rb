class JourneyLog

attr_reader :journey, :log
attr_accessor :current_fare

  def initialize
    @journey = Journey.new
    @log = []
  end

  def start(entry_station)
    clear_current_journey if in_journey?
    @journey.entry(entry_station)
  end

  def finish(exit_station)
    @journey.end(exit_station)
    store_log
  end

  def in_journey?
    @journey.in_journey?
  end

  def fare
    @journey.fare
  end

  def clear_current_journey
    @journey = Journey.new
  end

  private

  def store_log
    @log << @journey.current_journey
  end


end
