class Coupon < ActiveRecord::Base
  belongs_to :business

  validates_presence_of :business_id, :discount_percent, :price, :description

  def price_in_dollars
    price / 100
  end
end