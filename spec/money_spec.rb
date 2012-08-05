# encoding: UTF-8
require 'spec_helper'

describe DecimalPriceProduct do
  it { should allow_value('10.33').for(:price) }
  it { should allow_value(nil).for(:price) }
  it { should_not allow_value('  ').for(:price) }
  it { should_not allow_value('BOGUS').for(:price) }
  it { should_not allow_value('10€').for(:price) }
  it { should_not allow_value('10 EUR').for(:price) }

  it "supports reloading" do
    product = described_class.create!
    product.price = 10.97
    product.save!
    product.price = 199.32
    product.save!
    product.reload
    product.price.should == 199.32
  end
end