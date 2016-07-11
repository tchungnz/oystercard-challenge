require 'oystercard'
describe Oystercard do

  describe '#initialize' do
    context 'when initialized' do
      it 'will have a balance of 0' do
        expect(subject.balance).to eq 0
      end
    end
  end

  describe '.top_up' do
    context 'when given an argument' do
      it 'will accept the argument' do
        expect(subject).to respond_to(:top_up).with(1).argument
      end
      it 'will increase the balance by the value' do
        subject.top_up(5)
        expect(subject.balance).to eq 5
      end
      it 'will fail if balance will exceed limit' do
        subject.top_up(50)
        expect{subject.top_up(41)}.to raise_error "Exceeded limit of #{Oystercard::BALANCE_LIMIT} cannot top up. Current balance is 50"
      end
    end
  end


end
