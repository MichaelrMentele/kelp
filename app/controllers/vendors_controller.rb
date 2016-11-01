class VendorsController < ApplicationController
  before_filter :require_user
  before_filter :require_vendor

  private 

  def require_vendor
    if !current_user.vendor?
      flash[:warning] = "You don't have the credentials to do that."
      redirect_to businesses_path 
    end
  end 
end