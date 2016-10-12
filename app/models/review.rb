class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  validates_presence_of :rating, :description
end