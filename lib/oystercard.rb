class Oystercard
CREDIT_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
    @in_use = false
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

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_use?
    @in_use
  end

end
