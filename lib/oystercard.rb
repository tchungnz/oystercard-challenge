class Oystercard

  attr_accessor :balance
  #attr_accessor :in_journey

  BALANCE_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
    fail "Exceeded limit of #{BALANCE_LIMIT} cannot top up. Current balance is #{balance}" if (balance + value) >= 90
    self.balance += value
    return balance
  end

  def deduct(fare)
    self.balance -= fare
    return balance
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end


end
