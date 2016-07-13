require 'station'

describe Station do
let(:subject) {Station.new('station_name',1)}

  describe '#initialize' do
    it 'allows zone assignment when created' do
      expect(subject.zone).to eq 1
    end
    it 'allows name assignment when created' do
      expect(subject.name).to eq 'station_name'
    end
    it 'creates attributes name and zone' do
      expect(subject).to have_attributes(:name => 'station_name', :zone => 1)
    end
  end

end
