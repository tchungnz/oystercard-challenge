require_relative 'journey'

class Oystercard

  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

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
    deduct if in_journey?
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
  end

  private

  def deduct
    @balance -= @journey.fare
    clear_journey
  end

  def clear_journey
    @journey = Journey.new
  end

end
