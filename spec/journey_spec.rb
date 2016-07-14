require 'journey'
require 'oystercard'

describe Journey do

  let(:journey) { Journey.new }
  let(:station) {double :station, name: "Aldgate", zone: 1}
  let(:station2) {double :station, name: "Aldgate East", zone: 2}
  let(:station3) {double :station, name: "Liverpool St", zone: 3}
  let(:station4) {double :station, name: "Angel", zone: 4}
  let(:station5) {double :station, name: "Oldstreet", zone: 5}


  describe '#entry' do
    it 'captures entry station' do
      journey.entry(station)
      expect(journey.start).to eq(station)
    end
  end
  describe '#end' do
    it 'captures exit station' do
      journey.end(station)
      expect(journey.stop).to eq(station)
    end
  end
  describe '#in_journey?' do
    context 'when touch in' do
      it 'will be true' do
        journey.entry(station)
        expect(journey).to be_in_journey
      end
    end
    context 'when touch out' do
      it 'will be false' do
        journey.entry(station)
        journey.end(station)
        expect(journey).not_to be_in_journey
      end
    end
  end
  describe '#fare' do
    context 'when used normally with stations 1 to 2' do
      it 'returns fare' do
        journey.entry(station)
        journey.end(station2)
        expect(journey.fare).to eq 2
      end
    end

    context 'when used normally within the same zone' do
      it 'returns MINIMUM_FARE' do
        journey.entry(station)
        journey.end(station)
        expect(journey.fare).to eq 1
      end
    end

    context 'when used normally with stations 2 to 4' do
      it 'returns fare' do
        journey.entry(station2)
        journey.end(station4)
        expect(journey.fare).to eq 3
      end
    end

    context 'when used normally with stations 5 to 1' do
      it 'returns fare' do
        journey.entry(station5)
        journey.end(station)
        expect(journey.fare).to eq 5
      end
    end


    context 'when no entry' do
      it 'returns penalty fare' do
        journey.entry(station)
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
    context 'when no exit' do
      it 'returns penalty fare' do
        journey.end(station)
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end

  #describe '#zone_crossed' do
  #  context 'takes the different zones from stations' do
  #    it 'calculates the number of zones travelled' do
  #      journey.entry(station)
  #      journey.end(station2)
  #      expect(journey.zone_crossed).to eq(2)
  #    end
  #  end
  #end
end
