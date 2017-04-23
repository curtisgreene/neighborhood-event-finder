class EventsController < ApplicationController
  before_action :logged_in_user

  def index
    @events = Event.all
  end

  def nearby
    nearby_api_request = NycOpenDataAdapter.new(current_user)
    data = nearby_api_request.data
    @nearby_events = []
    data["items"].each do |event_data|
      event = Event.find_or_create_by(name: event_data["name"], start_time: event_data["startDate"])
      event = NycOpenDataAdapter.assign(event, event_data)
      event.save
      @nearby_events << event
    end
  end

  def search
    render :search
  end

  def results
    query_api_request = NycOpenDataAdapter.new(current_user, params)
    data = query_api_request.data
    @results = []
    data["items"].each do |event_data|
      event = Event.find_or_create_by(name: event_data["name"], start_time: event_data["startDate"])
      event = NycOpenDataAdapter.assign(event, event_data)
      event.save
      @results << event
    end
  end

  def show
    @event = Event.find(params[:id])
  end

end
