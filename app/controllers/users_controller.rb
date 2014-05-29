class UsersController < ApplicationController

    def index
      # @following = current_user.following?(current_user).map { |user| user.id }
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @concerts = @user.concerts.order('date DESC')

      # @followers = current_user.followers(current_user.id).each { |person| person}
      # @followed_people = current_user.following?(params[:id].to_i).each { |person| person}

    end

end
