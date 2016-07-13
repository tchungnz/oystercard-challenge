require 'station'

describe Station do

  describe '#initialize' do
    before(:each) do
      @station0 = Station.new("Aldgate", 1)
    end
    context 'when created' do
      it 'has a name' do
        expect(@station0.name).to eq "Aldgate"
      end
      it 'has a zone' do
        expect(@station0.zone).to eq 1
      end
    end
  end

end
