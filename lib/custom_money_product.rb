class CustomMoneyProduct < ActiveRecord::Base
  set_table_name 'integer_money_rails_products'

  validate :price_must_be_valid

  def price
    @price ||= (price_cents.nil? ? nil : Money.new(price_cents))
  end

  def price=(price)
    self[:price_cents] = price.nil? ? nil : Money.from_string(price).cents
    @price = price
  end

  def reload
    @price = nil
    super
  end

  def price_must_be_valid
    return if price.nil?
    # require a numeric from there
    errors.add(:price, 'is not numeric') unless parse_raw_value_as_a_number(self.price)
  end

  # taken from rails validates_numericality_of
  def parse_raw_value_as_a_number(raw_value)
    case raw_value
    # 0x10 will parsed as hex value and we don't want that
    when /\A0[xX]/
      nil
    else
      begin
        Kernel.Float(raw_value)
      rescue ArgumentError, TypeError
        nil
      end
    end
  end

end