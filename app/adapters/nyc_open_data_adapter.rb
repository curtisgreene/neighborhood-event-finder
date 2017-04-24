class NycOpenDataAdapter

  BASE_URL = "https://api.cityofnewyork.us/calendar/v1/search.htm?app_id=a64cc336&app_key=4b82d0291b83dc1c52ee0f19d9f4f93c"

  def initialize(current_user, params=nil)
    if params
      @params = params
      self.fetch_query_events
    else
      @current_user = current_user
      self.fetch_nearby_events
    end
  end

  def fetch_nearby_events
    borough_url = "&boroughs=#{@current_user.borough}"
    @complete_url = BASE_URL + borough_url + "&sort=DATE"
    @data = api_request
  end

  def fetch_query_events
    keys_we_want = ["keywords", "zip", "boroughs"]
    url_additions = []
    keys_we_want.each do |key|
      if @params[key].present?
        if @params[key].class == Array
          array_url = @params[key].join("%2C+").gsub(/[ ]/, '+').gsub(/[&]/, '%26')
          url_additions << "&#{key}=#{array_url}"
        else
          url_additions << "&#{key}=#{@params[key]}"
        end
      end
    end
    @complete_url = BASE_URL + url_additions.join("") + "&sort=DATE"
    @data = api_request
  end

  def api_request
    response = RestClient.get(@complete_url)
    JSON.parse(response)
  end

  def data
    @data
  end

  def self.assign(event, event_data)
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
    event
  end

end