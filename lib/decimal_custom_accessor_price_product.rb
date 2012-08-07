class DecimalCustomAccessorPriceProduct < ActiveRecord::Base
  validate :price_must_be_valid_amount_or_nil

  def price
    @price ||= amount
  end

  def price=(value)
    self[:amount] = value
    @price = value
  end

  def reload
    @price = nil
    super
  end

private
  def price_must_be_valid_amount_or_nil
    raw_value = price
    return if price.nil?
    errors.add(:price, "is not numeric (#{raw_value}.inspect)") unless parse_raw_value_as_a_number(price)
  end

  def parse_raw_value_as_a_number(raw_value)
    case raw_value
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
