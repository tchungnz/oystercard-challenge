require 'oystercard'

describe Oystercard do

  it 'get_balance' do
    oystercard = Oystercard.new
    expect(oystercard.get_balance).to eq 0
  end


  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.get_balance}.by 1
    end

    it 'raises an error if balance exceeds 90' do
      subject.top_up(50)
      expect{ subject.top_up(41)}. to raise_error "maximum balance is #{Oystercard::MAXIMUM_CAPACITY}"
    end

  end

  describe '#deduct' do
    it {is_expected.to respond_to(:deduct).with(1).argument}

    it 'will deduct the balance by the value' do
      expect{ subject.deduct 1}.to change{subject.get_balance}.by -1
    end
  end

  describe 'in_journey' do
    it 'will check if card has been touched in but not yet touched out' do
      expect( subject.in_journey ).to be false
    end
  end

  describe 'touch_in' do
    it 'will initiate a journey and change in_journey? to true' do
      subject.touch_in
      expect(subject.in_journey).to be true
    end
  end

  describe 'touch_out' do
    it 'will end jouney and change in_journey? to false' do
      subject.touch_out
      expect(subject.in_journey).to be false
    end
  end

end
