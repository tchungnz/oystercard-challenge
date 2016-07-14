require 'journey_log'

describe JourneyLog do
let(:station_1) {double :station}
let(:station_2) {double :station}

  describe '#initialize' do
    it 'creates a new journey' do
      expect(subject.journey).to be_an_instance_of Journey
    end
  end

  describe '#start' do
    it 'accept an entry station argument' do
      expect(subject).to respond_to(:start).with(1).argument
    end
  end

  describe '#finish' do
  it 'accept an exit station argument' do
    expect(subject).to respond_to(:finish).with(1).argument
  end
end

describe '#log' do
  it 'returns an array with the history of journeys' do
    subject.start(station_1)
    subject.finish(station_2)
    expect(subject.log).to include(:start => station_1, :stop => station_2)
  end
end

end

#  it 'sets entry and exit to nil' do
#    card.top_up(10)
#    card.touch_in(station0)
#    card.touch_out(station1)
#    expect(card.entry_station).to eq nil
#    expect(card.exit_station).to eq nil
#  end
#end


#describe '#in_journey?' do
#  it "returns in journey status" do
#    subject.top_up(10)
#    subject.touch_in(station0)
#    expect(subject.in_journey?).to eq true
#    subject.touch_out(station0)
#    expect(subject.in_journey?).to eq false
#  end
#end
