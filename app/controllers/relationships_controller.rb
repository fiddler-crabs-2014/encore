class RelationshipsController < ApplicationController
  respond_to :html, :js

  def create
    @followed = User.find(params[:followed_id])
    current_user.follow!(@followed)
    render json: {}, status: :ok
  end

  def unfollow
    followed = User.find(params[:followed_id])
    current_user.unfollow!(followed)
    render json: {}, status: :ok
  end
end
