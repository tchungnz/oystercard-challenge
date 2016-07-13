class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
FARE = 1
  attr_reader :balance, :log

  def initialize
    @balance = 0
    @journey = {}
    @log = []
  end

  def top_up(amount)
    fail top_up_error if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    #fail station_error unless station.is_a? Station
    fail min_balance_error if below_min?
    assign_entry(station)
  end

  def touch_out(station)
    deduct(FARE)
    assign_exit(station)
    log_journey
  end

  def in_journey?
    @journey.has_key?(:entry)
  end

  private

  def station_error
    'Not a station'
  end

  def deduct(amount)
    @balance -= amount
  end

  def below_min?
    balance < MIN_BALANCE
  end

  def min_balance_error
    "Balance is below £#{MIN_BALANCE}"
  end

  def balance_exceeded?(amount)
    balance + amount > MAX_BALANCE
  end

  def top_up_error
    "Balance cannot exceed #{MAX_BALANCE}."
  end

  def assign_entry(station)
    @journey[:entry] = station
  end

  def assign_exit(station)
    @journey[:exit] = station
  end

  def log_journey
    @log << @journey
    @journey = {}
  end
end
