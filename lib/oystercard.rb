class Oystercard

  attr_reader :get_balance
  attr_reader :in_journey

  MAXIMUM_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize(in_journey = false)
    @get_balance = 0
    @in_journey = in_journey
  end

  def top_up(amount)
    @get_balance += amount
    raise "maximum balance is £#{MAXIMUM_CAPACITY}" if @get_balance > MAXIMUM_CAPACITY
  end

  def deduct(value)
    @get_balance -= value
  end

  def touch_in
    raise "balance is <£#{MINIMUM_FARE}" if @get_balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end

#tim
