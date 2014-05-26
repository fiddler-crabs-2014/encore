class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
    @user = User.find(session[:user_id])
  end

end
