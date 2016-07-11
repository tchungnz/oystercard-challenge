class Oystercard

  attr_accessor :balance

  BALANCE_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance

  end

  def top_up(value)
    fail "Exceeded limit of #{BALANCE_LIMIT} cannot top up. Current balance is #{balance}" if (balance + value) >= 90
    self.balance += value
    return balance
  end

end
