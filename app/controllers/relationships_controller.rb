class RelationshipsController < ApplicationController
  before_filter :require_user

  def create
    relationship = Relationship.create(relationship_params.merge!(user: current_user))
    if relationship.followable_type == "User"
      flash[:success] = "You are now following #{relationship.followable.username}"
    elsif relationship.followable_type == "Business"
      flash[:success] = "You are now following #{relationship.followable.name}"
    end
    redirect_to :back
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followable_id, :followable_type)
  end
end