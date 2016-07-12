require 'oystercard'

describe Oystercard do
  let(:subject) { Oystercard.new }


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

  describe'#deduct' do
    before do
      subject.top_up 20
    end
    it 'deducts money from balance' do
      expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
    end
  end

  describe '#touch_in' do
    it "records a journey as in progress" do
      subject.top_up(1)
      expect(subject.touch_in).to(eq(true))
    end
    it 'raises error if balance is below a minimum amount' do
      expect{subject.touch_in}.to(raise_error("Balance is below £#{described_class::MIN_BALANCE}"))
    end
  end

  describe '#touch_out' do
    it "ends an in progress journey" do
      expect(subject.touch_out).to(eq(false))
    end
  end

  describe '#in_journey' do
    before do
      subject.top_up(10)
      subject.touch_in
    end
    it "is true when a card has been touched in" do
      expect(subject).to(be_in_journey)
    end
    it "is false when a card has been touched out" do
      subject.touch_out
      expect(subject).not_to(be_in_journey)
    end
  end

end
