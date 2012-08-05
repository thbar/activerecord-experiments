class DecimalPriceProduct < ActiveRecord::Base
  validate :price, :price_must_be_valid_amount_or_nil

private
  def price_must_be_valid_amount_or_nil
    # too bad: price_before_type_cast will equal nil if the string passed is empty
    raw_value = price_before_type_cast
    return if raw_value.nil?
    errors.add(:price, 'is not numeric') unless parse_raw_value_as_a_number(raw_value)
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
