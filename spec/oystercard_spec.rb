require 'oystercard'
require 'station'

describe Oystercard do
  let(:subject) { described_class.new}
  let(:entry_station) { double(:station, is_a?: Station) }
  let(:exit_station) { double(:station, is_a?: Station) }

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
    end
    it 'raises error if balance is below a minimum amount' do
      subject = described_class.new
      expect{subject.touch_in(entry_station)}.to(raise_error("Balance is below £#{described_class::MIN_BALANCE}"))
    end
    it 'only accepts station class objects' do
      expect{subject.touch_in(String.new)}.to raise_error 'Not a station'
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end
    it "deducts the fare from the balance" do
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by -Travel::MIN_FARE
    end
    it 'only accepts station class objects' do
      expect{subject.touch_out(String.new)}.to raise_error 'Not a station'
    end
  end

end
