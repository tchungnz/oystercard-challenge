class Oystercard

  attr_reader :get_balance

  MAXIMUM_CAPACITY = 90

  def initialize
    @get_balance = 0
  end

  def top_up(amount)
    @get_balance += amount
    raise "maximum balance is #{MAXIMUM_CAPACITY}" if @get_balance > MAXIMUM_CAPACITY
  end

end
