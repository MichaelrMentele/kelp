class Business < ActiveRecord::Base
  has_many :leading_relationships, as: :followable
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :followable_id, as: :followable
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :coupons
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  validates_presence_of :name, :blurb, :img_url, :synopsis, :location

  def has_coupons?
    coupons.count > 0
  end

  def reviews?
    reviews.count > 0
  end

  def self.active_sale_all
    all.select do |business|
      business.sale?
    end
  end

  def sale?
    coupons.where(for_sale: true).count > 0
  end

  def average_rating
    if not reviews.count == 0
      avg = reviews.map(&:rating).sum / reviews.count.to_f
      sprintf("%.1f", avg)
    else
      0
    end
  end
end