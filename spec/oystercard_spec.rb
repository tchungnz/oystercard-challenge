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

    it 'raises error if balance limit exceeded' do
      subject.top_up(80)
      expect{subject.top_up(20)}.to raise_error "Exceeded balance limit of £#{Oystercard::LIMIT}"
    end
  end

  describe '#deduct' do
    it {is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts fare from balance" do
      subject.top_up(80)
      expect(subject.deduct(20)).to eq 60
    end
  end

   describe '#touch_in' do
     it "sets in_journey to true" do
       subject.touch_in
       expect(subject).to be_in_journey
     end
   end

   describe '#touch_out' do
     it "sets in_journey to false" do
       subject.touch_out
       expect(subject).not_to be_in_journey
     end
   end

   describe '#in_journey?' do
     it "returns in journey status" do
       subject.touch_in
       expect(subject.in_journey?).to eq true
       subject.touch_out
       expect(subject.in_journey?).to eq false
     end
   end
end
