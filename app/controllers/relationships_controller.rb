class RelationshipsController < ApplicationController
  # respond_to :html, :js

  def create
    @followed = User.find(params[:relationship][:followed_id])
    current_user.follow!(@followed)
  end

  def destroy
    Relationship.destroy(params[:id])
  end
end
