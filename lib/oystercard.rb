class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Amount entered exceeds top limit of £#{MAX_BALANCE}" if maximum_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
  
  def touch_in
    "in use"
  end

  private
  def maximum_limit?(amount)
    balance + amount > MAX_BALANCE
  end
end
