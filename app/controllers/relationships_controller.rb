class RelationshipsController < ApplicationController

  def create
    @followed = User.find(params[:relationship][:followed_id])
    current_user.follow!(@followed)
    # respond_to do |format|
    #   format.js { @user = @followed}
    # end
    @relationship = Relationship.all
  end

  def destroy
    Relationship.destroy(params[:id])
  end
end
