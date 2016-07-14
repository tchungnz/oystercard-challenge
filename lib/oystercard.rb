require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    (@balance + amount) > LIMIT ? (fail "Exceeded balance limit of £#{LIMIT}") : @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient balance. Minimum £#{Journey::MINIMUM_FARE}" if  @balance < Journey::MINIMUM_FARE
    deduct if @journey_log.in_journey?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct
    @journey_log.clear_current_journey
  end

  def journey_log
    @journey_log.log
  end

  private

  def deduct
    @balance -= @journey_log.fare
  end

end
