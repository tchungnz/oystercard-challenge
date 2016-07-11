class Oystercard

  attr_accessor :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    self.balance += value
    return balance
  end

end
