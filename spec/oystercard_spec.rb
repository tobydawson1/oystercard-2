require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance)}

  it { is_expected.to respond_to(:touch_in) }

  it 'returns balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up card balance' do
      expect{subject.top_up(10)}.to change{subject.balance}.by(10)
    end

    it 'does not allow balance to exceed 90' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error("Amount entered exceeds top limit of £#{max_balance}")
    end
  end

  describe '#deduct' do
    it 'substracts money from balance' do
      expect{ subject.deduct(1) }.to change{subject.balance}.by(-1)
    end
  end

  describe '#touch_in' do
    it 'returns "in use" ' do
      expect( subject.touch_in).to eq("in use")
    end
  end
end
