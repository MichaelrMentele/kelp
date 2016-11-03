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

  def watched_reviewers
    following_relationships.where(followable_type: "User").map(&:followable)
  end

  def watched_businesses
    following_relationships.where(followable_type: "Business").map(&:followable)
  end

  def following_reviewers?
    watched_reviewers.count > 0
  end

  def following_businesses?
    watched_businesses.count > 0
  end

  def follows?(followable)
    !!following_relationships.find_by(followable_id: followable.id, followable_type: followable.class.name)
  end

  def has_coupons?
    coupons.count > 0
  end

  def has_reviews?
    reviews.count > 0
  end
end