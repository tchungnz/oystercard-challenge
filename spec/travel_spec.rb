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
      subject.assign_entry(station_a)
      subject.assign_exit(station_b)
    end
    it 'returns an array of hashes of entry/exit stations' do
      expect(subject.log).to eq ([{ entry: station_a, exit: station_b }])
    end
  end

  describe '#fare' do
    it 'charges minimum fare when a full journey has been completed' do
      min_fare =  subject.instance_variable_set(:@journey, {entry: station_a, exit: station_b})
      expect(subject.fare).to eq 1
    end
  end
  it 'charges a penality if touching in twice in a row' do
    subject.assign_entry(station_a)
    subject.assign_entry(station_b)
    expect(subject.fare).to eq 6
  end
end
