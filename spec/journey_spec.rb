require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { Journey.new }

  describe '#entry' do
    it 'captures entry station' do
      station = Station.new("Aldgate" ,2)
      subject.entry(station)
      expect(journey.start).to eq(station)
    end
  end
  describe '#end' do
    it 'captures exit station' do
      station = Station.new("Aldgate" ,2)
      subject.end(station)
      expect(journey.stop).to eq(station)
    end
  end
end
