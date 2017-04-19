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
      event = Event.find_or_create_by(name: event_data["name"])
      event.name = event_data["name"]
      event.description = event_data["shortDesc"]
      event.start_time = event_data["startDate"]
      event.end_time = event_data["endDate"]
      event.location = event_data["location"]
      event.borough = event_data["boroughs"] # can contain multiple borough
      event.website = event_data["website"]
      event.category = event_data["categories"] #can contain multiple categories
      event.address = event_data["address"]
      event.city = event_data["city"]
      event.state = event_data["state"]
      event.zip = event_data["zip"]
      event.address = event_data["address"]
      # all the columns
      event.save
      @nearby_events << event
    end
  end

  def search
    render :search
  end

  def results
    keys_we_want = ["name", "zip", "boroughs"]
    url_additions = []
    keys_we_want.each do |key|
      if params[key].present?
        if params[key].class == Array
          #join the array with whatever (%20+) and shovel into url_additions
        else
          url_additions << "&#{key}=#{params[key]}"
        end
      end
    end
    base_url = "https://api.cityofnewyork.us/calendar/v1/search.htm?app_id=a64cc336&app_key=4b82d0291b83dc1c52ee0f19d9f4f93c"
    #### search_terms SOMETHING GOES HERE ####
    complete_url = base_url + url_additions.join("") + "&sort=DATE"
    byebug
    response = RestClient.get(complete_url)
    data = JSON.parse(response)
    @results = []
    data["items"].each do |event_data|
      event = Event.find_or_create_by(name: event_data["name"])
      event.name = event_data["name"]
      event.description = event_data["shortDesc"]
      event.start_time = event_data["startDate"]
      event.end_time = event_data["endDate"]
      event.location = event_data["location"]
      event.borough = event_data["boroughs"] # can contain multiple borough
      event.website = event_data["website"]
      event.category = event_data["categories"] #can contain multiple categories
      event.address = event_data["address"]
      event.city = event_data["city"]
      event.state = event_data["state"]
      event.zip = event_data["zip"]
      event.address = event_data["address"]
      # all the columns
      event.save
      @results << event
    end
  end

  def show
    @event = Event.find(params[:id])
  end

end
