require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:station0) { double :station }
  let(:station1) { double :station }

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
      subject.touch_in(station0)
      expect(subject).to be_in_journey
    end

    it "throws an error when insufficient balance" do
      expect{subject.touch_in(station0)}.to raise_error "Insufficient balance. Minimum £#{Oystercard::MINIMUM_FARE}"
    end

    it "remembers entry station" do
      subject.top_up(10)
      subject.touch_in(station0)
      expect(subject.journey.start).to eq station0
    end

    context 'when in_journey' do
      it "charges penalty on touch in" do
        subject.top_up(10)
        subject.touch_in(station0)
        expect {subject.touch_in(station1)}.to change{subject.balance}.by(-6)
      end
    end

  end


  describe '#touch_out' do
    it "sets in_journey to false" do
      subject.top_up(10)
      subject.touch_in(station0)
      subject.touch_out(station0)
      expect(subject).not_to be_in_journey
    end

    it "charges fare on touch out" do
      subject.top_up(10)
      subject.touch_in(station0)
      expect {subject.touch_out(station0)}.to change{subject.balance}.by(-(Oystercard::MINIMUM_FARE))
    end

    context 'when no touch in' do
      it "charges penalty on touch out" do
        subject.top_up(10)
        expect {subject.touch_out(station0)}.to change{subject.balance}.by(-6)
      end
    end

    it 'sets entry and exit to nil' do
      card.top_up(10)
      card.touch_in(station0)
      card.touch_out(station1)
      expect(card.entry_station).to eq nil
      expect(card.exit_station).to eq nil
    end
  end

  describe '#in_journey?' do
    it "returns in journey status" do
      subject.top_up(10)
      subject.touch_in(station0)
      expect(subject.in_journey?).to eq true
      subject.touch_out(station0)
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#store_journey' do
    it 'stores journey as objects in journeys' do
      card.top_up(10)
      card.touch_in(station0)
      card.touch_out(station1)
      expect(subject.journeys[0]).to be_instance_of Journey
    end
  end


end
