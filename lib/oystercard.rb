class Oystercard
CREDIT_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail top_up_error if balance_exceeded?(amount)
    @balance += amount
  end

  def balance_exceeded?(amount)
    @balance + amount > CREDIT_LIMIT
  end

  def top_up_error
    "Balance cannot exceed #{CREDIT_LIMIT}."
  end

end
