class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def search
    render :search
  end

  def parse
    base_url = "https://api.cityofnewyork.us/calendar/v1/search.htm?app_id=a64cc336&app_key=4b82d0291b83dc1c52ee0f19d9f4f93c&"
    #do something with the params to interpolate into the url
    complete_url = base_url + something
    response = RestClient.get(complete_url)
    data = JSON.parse(response)
    @all_events = []
    data[:items].each do |event_data|
      @event = Event.new
      @event.name = event_data[:name]
      @event.description = event_data[:desc]
      # all the columns
      @event.save
      @all_events << @event
    end
  end


end
