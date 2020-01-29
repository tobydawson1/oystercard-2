class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "Amount entered exceeds top limit of £#{MAX_BALANCE}" if maximum_limit?(amount)
    @balance += amount
  end
  
  def touch_in(station)
    fail "Minimum fare of £#{MIN_BALANCE} not met" if minimum_balance?
    @entry_station = station
    @in_use = true
  end

  def touch_out
    @entry_station = nil
    deduct(MIN_BALANCE)
    @in_use = false
  end

  def in_journey?
    @in_use == true
  end

  private
  def maximum_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def minimum_balance?
    @balance < MIN_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
