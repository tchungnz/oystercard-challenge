require 'journey_log'

describe JourneyLog do

describe "entry_station" do
  context "when user taps in" do
    it "records the station" do
      station = Station.new("Aldgate", 2)
      expect(subject.entry_station(station)).to eq(station)
    end
  end
end

describe "exit_station" do
  context "when user taps in" do
    it "records the station" do
      station = Station.new("Aldgate", 2)
      expect(subject.entry_station(station)).to eq(station)
    end
  end
end


end
