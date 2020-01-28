require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance)}

  it 'returns balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up card balance' do
      expect{subject.top_up(10)}.to change{subject.balance}.by(10)
    end
  end

end
