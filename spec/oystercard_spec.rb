require 'oystercard'

describe Oystercard do

  it 'get_balance' do
    oystercard = Oystercard.new
    expect(oystercard.get_balance).to eq 0
  end

end
