class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def nearby
    base_url = "https://api.cityofnewyork.us/calendar/v1/search.htm?app_id=a64cc336&app_key=4b82d0291b83dc1c52ee0f19d9f4f93c&"
    borough_url = "boroughs=#{current_user.borough}"
    complete_url = base_url + borough_url + "&sort=DATE"
    response = RestClient.get(complete_url)
    data = JSON.parse(response)
    @nearby_events = []
    data["items"].each do |event_data|
      event = Event.find_or_create_by(name: event_data["name"], start_time: event_data["startDate"])
      event.assign(event_data)
      # all the columns
      event.save
      @nearby_events << event
    end
  end

  def search
    render :search
  end

  def results
    keys_we_want = ["keywords", "zip", "boroughs"]
    url_additions = []
    keys_we_want.each do |key|
      if params[key].present?
        if params[key].class == Array
          array_url = params[key].join("%2C+").gsub(/[ ]/, '+').gsub(/[&]/, '%26')
          #join the array with whatever (%20+) and shovel into url_additions
          url_additions << "&#{key}=#{array_url}"
        else
          url_additions << "&#{key}=#{params[key]}"
        end
      end
    end
    base_url = "https://api.cityofnewyork.us/calendar/v1/search.htm?app_id=a64cc336&app_key=4b82d0291b83dc1c52ee0f19d9f4f93c"
    #### search_terms SOMETHING GOES HERE ####
    complete_url = base_url + url_additions.join("") + "&sort=DATE"
    response = RestClient.get(complete_url)
    data = JSON.parse(response)
    @results = []
    data["items"].each do |event_data|
      @event = Event.find_or_create_by(name: event_data["name"], start_time: event_data["startDate"])
      @event.assign(event_data)
      @event.save
      @results << @event
    end
  end

  def show
    @event = Event.find(params[:id])
  end

end
