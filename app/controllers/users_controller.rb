class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @concerts = @user.concerts.order('date DESC')
      unless @concerts == []
        @year = @concerts.first.date.strftime('%Y')
      end

      @followers = @user.followers(params[:id]).each { |person| person}

      @users_following = @user.following(params[:id]).each { |person| person }

    end

end
