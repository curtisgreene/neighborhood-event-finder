class AppointmentsController < ApplicationController
  before_action :logged_in_user

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

  def destroy
    #byebug
    @appointment = Appointment.find_by(user_id: current_user.id, event_id: params[:event_id])
    @appointment.delete
    redirect_to user_path(current_user)
  end
end
