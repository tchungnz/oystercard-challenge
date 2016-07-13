require 'travel'

describe Travel do

  let(:station_a) { double(:station) }
  let(:station_b) { double(:station) }
  let(:oystercard) { double(:oystercard) }


  describe '#initialize' do
    it 'starts with no journey in progress' do
      expect(subject.journey).to be_empty
    end
    it 'starts with an empty log' do
      expect(subject.log).to be_empty
    end
  end

  describe '#log' do
    before do
      subject.journey_entry(station_a)
      subject.journey_exit(station_b)
    end
    it 'returns an array of hashes of entry/exit stations' do
      expect(subject.log).to eq ([{ entry: station_a, exit: station_b }])
    end
  end

  describe '#journey_complete?' do
    it 'will be false before a journey starts' do
    expect(subject.journey_complete?).to be true
  end
    it 'will be false when a station is entered' do
      subject.journey_entry(station_a)
      expect(subject.journey_complete?).to be false
    end
    it 'will be false when a station is entered twice' do
      subject.journey_entry(station_a)
      subject.journey_entry(station_b)
      expect(subject.journey_complete?).to be false
    end
    it 'will be true when a station is entered and then exited' do
      subject.journey_entry(station_a)
      subject.journey_exit(station_b)
      expect(subject.journey_complete?).to be true
    end
    it 'will be false when a station is exited and then exited' do
      subject.journey_exit(station_a)
      subject.journey_exit(station_b)
      expect(subject.journey_complete?).to be true
    end
  end

  describe '#fare' do
    it 'is the minimum fare when a station is entered and then exited' do
      subject.journey_entry(station_a)
      subject.journey_exit(station_b)
      expect(subject.fare).to eq Travel::MIN_FARE
    end
    it 'is the penalty fare when a station is entered and then entered' do
      subject.journey_entry(station_a)
      subject.journey_entry(station_b)
      expect(subject.fare).to eq Travel::MAX_FARE
    end
    it 'is the penalty fare when a station is exited and then exited' do
      subject.journey_exit(station_a)
      subject.journey_exit(station_b)
      expect(subject.fare).to eq Travel::MAX_FARE
    end
  end

end
