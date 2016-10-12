class Business < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :name, :blurb, :img_url, :synopsis, :location

end