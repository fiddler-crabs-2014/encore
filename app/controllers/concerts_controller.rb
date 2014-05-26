class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
  end

end
