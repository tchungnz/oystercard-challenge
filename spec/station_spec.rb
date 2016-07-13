require 'station'

describe Station do
let(:subject) {Station.new('station_name',1)}

  describe '#initialize' do
    it 'allows zone assignment when created' do
      expect(subject.zone).to eq 1
    end
    it 'allows name assignment when created' do
      expect(subject.station_name).to eq 'station_name'
    end
  end

end
