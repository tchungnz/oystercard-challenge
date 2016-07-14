require_relative 'oystercard'
require_relative 'station'
require_relative 'journey'

#puts 'create a new card'
#p oystercard = Oystercard.new
#
##puts 'checks card journey'
##puts journey = Journey.new
#
#puts 'create a new station'
#puts station1 = Station.new("Waterloo", 1)
#
#puts 'create a new station'
#puts station2 = Station.new("Sidcup", 5)
##
##puts 'create a new station'
##puts station3 = Station.new("Kingston", 5)
##
#puts 'top-up card'
#puts oystercard.top_up(5)
#
#puts 'check balance'
#puts oystercard.balance
#
#puts 'check journey history'
#puts oystercard.journey_history
#
#puts 'card is in journey?'
#puts oystercard.in_journey?
#
#puts 'card taps in'
#puts oystercard.touch_in(station1)
##
#puts 'checks card journey'
#puts journey.start

#puts 'card taps out'
#puts oystercard.touch_out(station2)
#
#puts 'check balance'
#puts oystercard.balance
#
#puts 'check journey history'
#puts oystercard.journey_history
########################################

puts 'create a new card'
p oystercard = Oystercard.new

puts 'create a new station'
puts station1 = Station.new("Waterloo", 1)

puts 'create a new station'
puts station2 = Station.new("Sidcup", 5)

puts 'top-up card'
puts oystercard.top_up(50)

puts 'card taps in'
puts oystercard.touch_in(station1)

puts 'card taps out'
puts oystercard.touch_out(station2)

puts oystercard.balance #charged fare

puts 'card taps out'
puts oystercard.touch_out(station1)

puts oystercard.balance #charged fine

puts 'card taps out'
puts oystercard.touch_out(station1)

puts oystercard.balance #charged fine

puts 'card taps in'
puts oystercard.touch_in(station1)

puts 'card taps in'
puts oystercard.touch_in(station2)
#
#puts oystercard.balance #charged fine
#
puts 'card taps out'
puts oystercard.touch_out(station1)
#
#puts oystercard.balance #charged fare

puts 'journey log'
p oystercard.journeys
