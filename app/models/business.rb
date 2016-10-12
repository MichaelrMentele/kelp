class Business < ActiveRecord::Base
  validates_presence_of :name, :blurb, :img_url, :synopsis, :location

end