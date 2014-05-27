class RelationshipsController < ApplicationController

  def create
    @followed = User.find(params[:id])
    current_user.follow!(@followed)
    # respond_to do |format|
    #   format.js { @user = @followed}
    # end
    @relationship = Relationship.all
  end

  def destroy
    relationship_id = Relationship.where(follower_id: current_user.id, followed_id: params[:id])[0].id
    Relationship.destroy(relationship_id)

    @relationship = Relationship.all
  end
end
