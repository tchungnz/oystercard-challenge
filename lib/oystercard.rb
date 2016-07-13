require_relative 'travel'
require_relative 'station'

class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @journey_info = Travel.new
  end

  def top_up(amount)
    fail top_up_error if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail station_error unless station.is_a? Station
    fail min_balance_error if below_min?
    @journey_info.assign_entry(station)
  end

  def touch_out(station)
    fail station_error unless station.is_a? Station
    deduct(@journey_info.fare)
    @journey_info.assign_exit(station)
  end

  def in_journey?
    @journey_info::journey.has_key?(:entry)
  end

  def history
    @journey_info.log
  end

  private

  def station_error
    'Not a station'
  end

  def deduct(fare)
    @balance -= amount
  end

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
