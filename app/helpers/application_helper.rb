module ApplicationHelper
  def meta(business)
    "#{business.average_rating} Stars (#{business.reviews.count} Reviews)"
  end

  def options_for_business_reviews(selected=nil)
    options_for_select(
      [5,4,3,2,1].map { |num| [pluralize(num, "Star"), num]}, selected
    )
  end
end
