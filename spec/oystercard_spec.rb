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
      subject.top_up(10.00)
      expect(subject.balance).to eq 10.00
    end

    it 'cannot exceed the credit limit' do
      max_out = described_class::CREDIT_LIMIT
      subject.top_up max_out
      expect{subject.top_up(0.01)}.to raise_error "Balance cannot exceed #{max_out}."
    end
  end

end
