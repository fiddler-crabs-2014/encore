class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @concerts = @user.concerts.order('date DESC')

      @followers = current_user.followers(params[:id]).each { |person| person}
      # @followed_people = current_user.following?(params[:id].to_i).each { |person| person}

    end

end
