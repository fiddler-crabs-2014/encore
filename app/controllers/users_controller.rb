class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @concerts = @user.concerts.order('date DESC')

      @followers = @user.followers(params[:id]).each { |person| person}

      binding.pry
      # @followed_users = @user.following?(params[:id]).each { |person| person }

      # @followed_people = current_user.following?(params[:id]).each { |person| person}

    end

end
