class User < ActiveRecord::Base
  has_many :reviews
  has_many :businesses, foreign_key: "owner_id"

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email

  has_secure_password validations: false

  def vendor?
    vendor
  end

end