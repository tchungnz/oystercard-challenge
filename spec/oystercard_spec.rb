require 'oystercard'

describe Oystercard do
  let(:subject) { Oystercard.new }
  let(:station) { double :station }

describe 'initialize' do
  it "has an empty journey array" do
    expect(subject.journeys).to eq []
  end

end

  describe '#balance' do

    it { is_expected.to respond_to(:balance) }

    it 'returns balance of oystercard' do
      expect(subject.balance).to eq 0
    end
  end

  describe'#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up card balance' do
      subject.top_up(10.00)
      expect(subject.balance).to eq 10.00
    end

    it 'raises error if balance limit exceeded' do
      subject.top_up(80)
      expect{subject.top_up(20)}.to raise_error "Exceeded balance limit of £#{Oystercard::LIMIT}"
    end
  end


  describe '#touch_in' do
    it "sets in_journey to true" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "throws an error when insufficient balance" do
      expect{subject.touch_in(station)}.to raise_error "Insufficient balance. Minimum £#{Oystercard::MINIMUM_FARE}"
      expect(subject).not_to be_in_journey
    end

    it "remembers entry station" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it "sets in_journey to false" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "charges fare on touch out" do
      subject.top_up(10)
      subject.touch_in(station)
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-(Oystercard::MINIMUM_FARE))
    end

    it "remembers exit station" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end

    it "forgets the entry station on touch out" do
      subject.top_up(10)
      subject.touch_in(station)
      expect {subject.touch_out(station)}.to change{subject.entry_station}.to(nil)
    end
  end

  describe '#in_journey?' do
    it "returns in journey status" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end
  end

end
