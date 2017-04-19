class Event < ApplicationRecord

  has_many :appointments
  has_many :users, through: :appointments

	def assign(event_data)
		name = event_data["name"]
    description = event_data["shortDesc"]
    start_time = event_data["startDate"]
    end_time = event_data["endDate"]
    location = event_data["location"]
    borough = event_data["boroughs"] # can contain multiple borough
    website = event_data["website"]
    category = event_data["categories"] #can contain multiple categories
    address = event_data["address"]
    city = event_data["city"]
    state = event_data["state"]
    zip = event_data["zip"]
    address = event_data["address"]
  end
  
end
