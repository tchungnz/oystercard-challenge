class Oystercard

  attr_reader :get_balance
  attr_reader :station

  MAXIMUM_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize(in_journey = false)
    @get_balance = 0
  end

  def top_up(amount)
    @get_balance += amount
    raise "maximum balance is £#{MAXIMUM_CAPACITY}" if @get_balance > MAXIMUM_CAPACITY
  end

  def touch_in(station)
    raise "balance is <£#{MINIMUM_FARE}" if @get_balance < MINIMUM_FARE
    @station = station
  end

  def touch_out
    deduct
    @station = nil
  end

  def in_journey
    @station != nil
  end

private

  def deduct(value = MINIMUM_FARE)
    @get_balance -= value
  end

end
