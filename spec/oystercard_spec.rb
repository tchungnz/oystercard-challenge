require 'oystercard'

describe Oystercard do
  let(:subject) { described_class.new}
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'returns balance of oystercard' do
      expect(subject.balance).to eq 0
    end
  end

  describe'#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'tops up card balance' do
      expect{ subject.top_up(10) }.to  change{ subject.balance }.by 10
    end
    it 'cannot exceed the credit limit' do
      max_out = described_class::MAX_BALANCE
      subject.top_up max_out
      expect{subject.top_up(0.01)}.to raise_error "Balance cannot exceed #{max_out}."
    end
  end

  describe '#touch_in(station)' do
    before do
      subject.top_up(1)
      allow(entry_station).to receive(:is_a?).with(Station) {true}
    end
    it "records a journey as in progress" do
      expect(subject.touch_in(entry_station)).to eq entry_station
    end
    it 'raises error if balance is below a minimum amount' do
      subject = described_class.new
      expect{subject.touch_in(entry_station)}.to(raise_error("Balance is below £#{described_class::MIN_BALANCE}"))
    end
    #it 'only accepts station class objects' do
    #  expect{subject.touch_in(String.new)}.to raise_error 'Not a station'
    #end
  end

  describe '#touch_out' do
    before do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end
    it "ends an in progress journey" do
      expect(subject.touch_out(exit_station)).to(eq({}))
    end
    it "deducts the fare from the balance" do
      fare = -(described_class::FARE)
      expect{subject.touch_out(exit_station)}.to(change{subject.balance}.by(fare))
    end
  end

  describe '#in_journey?' do
    before do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end
    it "is true when a card has been touched in" do
      expect(subject).to(be_in_journey)
    end
    it "is false when a card has been touched out" do
      subject.touch_out(exit_station)
      expect(subject).not_to(be_in_journey)
    end
    it 'starts with no journey in progress' do
      subject = Oystercard.new
      expect(subject).not_to(be_in_journey)
    end
  end

  describe '#log' do
    before do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
    it 'returns an array of hashes of entry/exit stations' do
      expect(subject.log).to eq ([{ entry: entry_station, exit: exit_station }])
    end
    it 'returns an array of hashes of journeys' do
      entry_station_2 = double(:station)
      exit_station_2 = double(:station)
      subject.touch_in(entry_station_2)
      subject.touch_out(exit_station_2)
      expect(subject.log).to eq ([{ entry: entry_station, exit: exit_station },
                                   {entry: entry_station_2, exit: exit_station_2}])

    end
    it 'has an empty log of journeys by default' do
      subject = Oystercard.new
      expect(subject.log).to be_empty
    end
  end


end
