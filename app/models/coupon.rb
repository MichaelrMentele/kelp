class Coupon < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  validates :price, numericality: { only_integer: true, greater_than: 49 }
  validates :discount_percent, numericality: {only_integer: true, less_than: 100 }
  validates_presence_of :business_id, :discount_percent, :price, :description

  def price_in_dollars
    price / 100
  end

  def price_in_cents
    price
  end
end