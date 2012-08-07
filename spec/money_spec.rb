# encoding: UTF-8
require 'spec_helper'

shared_examples :product do
  it { should allow_value('10.33').for(:price) }
  it { should allow_value(nil).for(:price) }
  it { should_not allow_value('  ').for(:price) }
  it { should_not allow_value('BOGUS').for(:price) }
  it { should_not allow_value('10€').for(:price) }
  it { should_not allow_value('10 EUR').for(:price) }
  it { should_not allow_value('10,30').for(:price) }

  it "supports reloading" do
    product = described_class.create!(price: 10.97)
    # put some amount in there but do not save it
    product.price = 199.32
    product.reload.price.should == 10.97
  end

  it "is valid after loading" do
     product = described_class.create!(price: 1999.23)
     product = described_class.find(product.id)
     product.price.should == 1999.23
     product.should be_valid
  end

  it "works with update_attributes" do
    product = described_class.create!(price: 100.3)
    product.update_attributes!(price: 300.28)
    product.price.should == 300.28
    product.reload.price.should == 300.28
    described_class.find(product.id).price.should == 300.28
  end
end

describe DecimalPriceProduct do
  it_behaves_like :product
end

describe DecimalCustomAccessorPriceProduct do
  it_behaves_like :product
end

#describe IntegerMoneyRailsProduct do
#  it_behaves_like :product
#end

describe CustomMoneyProduct do
  it_behaves_like :product
end

describe ComposedOfProduct do
  it_behaves_like :product
end