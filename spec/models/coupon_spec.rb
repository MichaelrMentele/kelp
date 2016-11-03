validates :price, numericality: { only_integer: true, greater_than: 49 }
validates :discount_percent, numericality: {only_integer: true, less_than: 100 }

require 'rails_helper'

describe Coupon do 
  it { should validate_presence_of(:business_id) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:discount_percent) }
  it { should validate_presence_of(:description) }
  it { should validate_numericality_of(:price).only_integer }
  it { should validate_numericality_of(:price).greater_than: 50 }
  it { should validate_numericality_of(:discount_percent).only_integer }
  it { should validate_numericality_of(:discount_percent).is_less_than: 100 }
  it { is_expected.to belong_to(:business) }
end