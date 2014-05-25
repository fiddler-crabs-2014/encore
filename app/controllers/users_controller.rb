class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @concerts = ["June 9, 2014", "January 30, 2012", "October 13, 2010", "November 29, 2014"]
    end

end
