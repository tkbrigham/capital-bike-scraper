String.class_eval do
  def round_down(amount)
    (self.to_i - (self.to_i % amount)).to_s
  end

  def round_up(amount)
    (self.to_i - (self.to_i % amount) + amount).to_s
  end
end

Fixnum.class_eval do
  def round_down(amount)
    self - (self % amount)
  end
  
  def round_up(amount)
    self - (self % amount) + amount
  end
end

Time.class_eval do
  def round_down(amount_and_unit)
    amount, unit = amount_and_unit.split('.')
    diff = self.amount_of(unit) % amount.to_i
    self - diff.send(unit)
  end

  def round_up(amount_and_unit)
    amount, unit = amount_and_unit.split('.')
    round_down(amount_and_unit) + amount.to_i.send(unit)
  end

  def amount_of(unit)
    self.to_a[mapping[unit.to_sym]].to_i
  end

  def mapping
    { seconds: 0, minutes: 1, hours: 2, days: 3, months: 4, years: 5 }
  end

  def mil_time
    "#{self.hour}#{self.min}".to_i
  end
end

