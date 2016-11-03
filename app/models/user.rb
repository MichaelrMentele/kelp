class User < ActiveRecord::Base
  has_many :following_relationships, class_name: "Relationship", foreign_key: :user_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :followable_id, as: :followable
  has_many :reviews
  has_many :businesses, foreign_key: "owner_id"
  has_many :coupons

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email

  has_secure_password validations: false

  def vendor?
    vendor
  end

  def has_coupons?
    coupons.count > 0
  end

  def has_reviews?
    reviews.count > 0
  end
end