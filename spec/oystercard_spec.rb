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

  describe '.deduct' do
    context 'when given an argument' do
      it 'will accept the argument' do
        expect(subject).to respond_to(:deduct).with(1).argument
      end
      it 'will reduce the balance by the fare' do
        subject.top_up(50)
        subject.deduct(5)
        expect(subject.balance).to eq 45
      end
      it 'will reduce the balance by the fare' do
        subject.top_up(10)
        subject.deduct(15)
        expect(subject.balance).to eq (-5)
      end
    end
  end

  describe '.touch_in' do
    context 'when called' do
      it 'will return true' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end
  end

  describe '.touch_out' do
    context 'when called' do
      it 'will return false' do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end


end
