class Oystercard

  attr_reader :get_balance

  def initialize
    @get_balance = 0
  end

  def top_up(amount)
    @get_balance += amount
  end

end
