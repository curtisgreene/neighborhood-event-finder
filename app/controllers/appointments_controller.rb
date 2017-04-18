class AppointmentsController < ApplicationController

  def new
    @events = Event.all
    @users = User.all
    @appointment = Appointment.new
  end

  def create
    @event = Event.find(params[:id])
    @user = current_user
    @appointment = Appointment.new(user_id: @user.id, event_id: @event.id)
    @appointment.save
    redirect_to user_path(@user)
  end

end
