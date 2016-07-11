require 'oystercard'
describe Oystercard do

  it 'will have a balance of 0 when initialized' do
    expect(subject.balance).to eq 0
  end

end
