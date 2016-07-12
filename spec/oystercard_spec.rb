require 'oystercard'

describe Oystercard do
  let(:station) {double :station}

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
      expect{ subject.top_up(41)}. to raise_error "maximum balance is £#{Oystercard::MAXIMUM_CAPACITY}"
    end

  end

  describe 'in_journey' do
    it 'if an entry station is given, return true' do
      subject.top_up(1)
      subject.touch_in(station)
      expect( subject.in_journey ).to be true
    end
  end

  describe 'touch_in' do
    it 'will initiate a journey and change in_journey? to true' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey).to be true
    end
    it 'will not touch_in if balance is < £1' do
      subject.top_up(0.50)
      expect{subject.touch_in(station)}.to raise_error "balance is <£#{Oystercard::MINIMUM_FARE}"
    end
  end

  describe 'touch_out' do
    it 'will end jouney and change in_journey? to false' do
      subject.touch_out
      expect(subject.in_journey).to be false
    end
    it 'will deduct the MINIMUM_FARE from the card' do
      expect{ subject.touch_out }.to change{ subject.get_balance }.by -Oystercard::MINIMUM_FARE
    end
    it 'will reset the entry station value to nil' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{subject.touch_out}.to change {subject.station}.to nil
    end
  end

  describe 'entry_station' do
    it 'will store the entry station on the card' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.station).to eq station
  end

end

end
