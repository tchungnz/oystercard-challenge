require 'oystercard'

describe Oystercard do
  #subject(:card) { Oystercard.new }
  let(:station0) {double :station, name: "Aldgate", zone: 1 }
  let(:station1) { double :station }
  let(:card) {described_class.new}

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
    it "throws an error when insufficient balance" do
      expect{subject.touch_in(station0)}.to raise_error "Insufficient balance. Minimum £#{Journey::MINIMUM_FARE}"
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
    before do
      subject.top_up(10)
    end
    it "charges fare on touch out" do
      subject.touch_in(station0)
      expect {subject.touch_out(station0)}.to change{subject.balance}.by(-(Journey::MINIMUM_FARE))
    end
    context 'when no touch in' do
      it "charges penalty on touch out" do
        expect {subject.touch_out(station0)}.to change{subject.balance}.by(-6)
      end
    end
  end

end
