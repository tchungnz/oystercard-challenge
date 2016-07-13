require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { Journey.new }

  describe '#entry' do
    it 'captures entry station' do
      station = Station.new("Aldgate", 2)
      subject.entry(station)
      expect(journey.start).to eq(station)
    end
  end
  describe '#end' do
    it 'captures exit station' do
      station = Station.new("Aldgate", 2)
      subject.end(station)
      expect(journey.stop).to eq(station)
    end
  end
  describe '#in_journey?' do
    context 'when touch in' do
      it 'will be true' do
        station = Station.new("Aldgate", 2)
        subject.entry(station)
        expect(subject).to be_in_journey
      end
    end
    context 'when touch out' do
      it 'will be false' do
        station = Station.new("Aldgate", 2)
        subject.entry(station)
        subject.end(station)
        expect(subject).not_to be_in_journey
      end
    end
  end
  describe '#fare' do
    context 'when used normally with stations' do
      it 'returns MINIMUM_FARE' do
        station = Station.new("Aldgate", 2)
        station2 = Station.new("Aldgate East", 1)
        subject.entry(station)
        subject.end(station2)
        expect(subject.fare).to eq Oystercard::MINIMUM_FARE
      end
    end
    context 'when no entry' do
      it 'returns penalty fare' do
        station = Station.new("Aldgate", 2)
        subject.entry(station)
        expect(subject.fare).to eq 6
      end
    end
    context 'when no exit' do
      it 'returns penalty fare' do
        station = Station.new("Aldgate", 2)
        subject.end(station)
        expect(subject.fare).to eq 6
      end
    end
  end
end
