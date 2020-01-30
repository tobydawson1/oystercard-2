require 'oystercard'

describe Oystercard do

  let(:station) {double :station}
  let(:station2) {double :station}

  it { is_expected.to respond_to(:balance)}

  it { is_expected.to respond_to(:touch_in).with(1).argument  }

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

  describe '#touch_in' do

    it 'raises an error if minimum fare not met' do
      min_balance = Oystercard::MIN_BALANCE
      expect{ subject.touch_in(station) }.to raise_error("Minimum fare of £#{min_balance} not met")
    end

  end


  describe '#touch_out' do

    before do 
    subject.top_up(10)
    end

    it 'returns "not in use"' do
      expect(subject.in_journey?).to eq false
    end

    it 'charges for journey' do
      min_balance = Oystercard::MIN_BALANCE
      subject.touch_in(station)
      expect{subject.touch_out(station2)}.to change{subject.balance}.by(-min_balance)
    end
  end

  context 'when not in journey' do
    it 'returns false' do
      expect(subject.in_journey?).to be false
    end

  end

  context 'when tapped in' do
    before do
      subject.top_up(10)
      subject.touch_in(station)
    end

    it 'returns true' do
      expect(subject.in_journey?).to be true
    end

    it 'stores entry station' do
      expect(subject.journeys.entry_station).to eq station
    end

  end

  context 'when tapped out' do
    before do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station2)
    end

    it 'stores exit station' do
      expect(subject.journeys.exit_station).to eq station2
    end

    it 'stores entry and exit stations' do
      expect(subject.journeys.journeys).to include(:entry_station => station, :exit_station => station2)
    end

    it 'changes entry station to nil' do
      expect(subject.journeys.entry_station).to eq nil
    end
  end

end
