class RelationshipsController < ApplicationController
  respond_to :html, :js

  def create
    @followed = User.find(params[:relationship][:followed_id])
    current_user.follow!(@followed)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    # Relationship.destroy(params[:id])
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
