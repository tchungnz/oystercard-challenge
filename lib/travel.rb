
class Travel

MIN_FARE = 1
MAX_FARE = 6

attr_reader :log, :journey, :fare

  def initialize
    @journey = {}
    @log = []
    @journey_complete = true
    @penalty = false
    @fare = MIN_FARE
  end

  def journey_entry(station)
    start_journey
    @journey[:entry] = station
  end

  def journey_exit(station)
    @journey[:exit] = station
    finish_journey
  end

  def journey_complete?
    @journey_complete
  end

  def fare
    if @penalty == false
      @fare = MIN_FARE
    else
      @fare = MAX_FARE
    end
  end

private

  def start_journey
    if @journey_complete == true
       @journey_complete = false
    else
      @penalty = true
      log_journey
    end
  end

  def finish_journey
    if @journey_complete == false
       @journey_complete = true
       @penalty = false
       log_journey
     else
       @penalty = true
       log_journey
    end
  end

  def log_journey
    @log << @journey
    @journey = {}
  end

end
