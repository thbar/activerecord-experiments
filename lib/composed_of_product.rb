# Save the value for custom validations
# see http://pivotallabs.com/users/jdean/blog/articles/1709-creating-user-friendly-validation-messages-with-the-money-gem
Money.class_eval do
  attr_accessor :original_value
end

class ComposedOfProduct < ActiveRecord::Base
  set_table_name 'integer_money_rails_products'
  validate :price_must_be_numeric

  composed_of :price,
              :class_name => "Money",
              :mapping => [%w(price_cents cents)],
              :allow_nil => true,
              :constructor => Proc.new { |cents| cents.nil? ? nil : Money.new(cents) },
              :converter => Proc.new { |value|
                if value.nil?
                  nil
                else
                  money = Money.from_string(value)
                  # store original value to forbid non numeric input
                  money.original_value = value
                  money
                end
              }

  def price_must_be_numeric
    unless price.nil? || price.original_value.nil?
      errors.add(:price, 'is not numeric') unless parse_raw_value_as_a_number(price.original_value)
    end
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