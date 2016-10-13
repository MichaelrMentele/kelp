class Business < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :name, :blurb, :img_url, :synopsis, :location

  def average_rating
    unless reviews.count == 0
      avg = reviews.map(&:rating).sum / reviews.count.to_f
      sprintf("%.1f", avg)
    else
      0
    end
  end
end