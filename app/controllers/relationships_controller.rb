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
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
