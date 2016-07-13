
class Travel

MIN_FARE = 1
MAX_FARE = 6

attr_reader :log, :journey

  def initialize
    @journey = {}
    @log = []
    @complete = true
    @penalty = false
  end

  def assign_entry(station)
    start_journey
    @journey[:entry] = station
  end

  def assign_exit(station)
    finish_journey
    @journey[:exit] = station
    log_journey
  end

  def fare
    if @penality == true
       @penality = false
      MAX_FARE
    else
      MIN_FARE
    end
  end

private

  def start_journey
    if @complete == true
       @complete = false
    else
      @penalty = true
      log_journey
    end
  end


  def finish_journey
    if @complete == false
       @complete = true
    else
      @penalty = true
      @journey = {}
    end
  end

  def log_journey
    @log << @journey
    @journey = {}
  end
end
