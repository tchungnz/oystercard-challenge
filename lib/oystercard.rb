require_relative 'journey'

class Oystercard

  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  attr_reader :journey

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    (@balance + amount) > LIMIT ? (fail "Exceeded balance limit of £#{LIMIT}") : @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient balance. Minimum £#{MINIMUM_FARE}" if  @balance < MINIMUM_FARE
    deduct(true) if in_journey?
    new_journey(entry_station)
  end

  def new_journey(entry_station)
    @journey.entry(entry_station)
  end

  def touch_out(exit_station)
    @journey.end(exit_station)
    store_journey
    deduct
  end

  def in_journey?
    @journey.in_journey?
  end

  def store_journey
    @journeys << @journey.journey
    clear_journey
  end

  private

  def deduct(fine = false)
    @balance -= @journey.fare
    if fine = true
      @journey = Journey.new
    end
  end

  def clear_journey
    @journey = Journey.new
  end

end
