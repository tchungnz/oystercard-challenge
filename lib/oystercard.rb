class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail top_up_error if balance_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail min_balance_error if below_min?
    @in_journey = true
  end

  def touch_out
    deduct(FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

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

end
