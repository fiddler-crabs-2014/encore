class AttendedConcertsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @concert = Concert.find(params[:concert_id])
    @user.attended_concerts.create(concert_id: @concert.id)
    render text: "Concert added to your profile!"
  end

end
