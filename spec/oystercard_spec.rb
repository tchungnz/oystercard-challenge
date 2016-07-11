require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  describe '#balance' do
    it 'returns balance of oystercard' do
      expect(subject.balance).to eq 0
    end
  end

end
