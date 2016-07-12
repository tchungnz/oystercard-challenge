class Oystercard

  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :station

  def initialize
    @balance = 0
    @station = nil
  end

  def top_up(amount)
    (@balance + amount) > LIMIT ? (fail "Exceeded balance limit of £#{LIMIT}") : @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance. Minimum £#{MINIMUM_FARE}" if  @balance < MINIMUM_FARE
    @station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @station = nil
  end

  def in_journey?
    !!@station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
