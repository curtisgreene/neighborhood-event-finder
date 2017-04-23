class Event < ApplicationRecord

  has_many :appointments
  has_many :users, through: :appointments

  
	def assign(event_data)
	  self.name = event_data["name"]
    self.description = event_data["shortDesc"]
    self.start_time = event_data["startDate"]
    self.end_time = event_data["endDate"]
    self.location = event_data["location"]
    self.borough = event_data["boroughs"] # can contain multiple borough
    self.website = event_data["website"]
    self.category = event_data["categories"] #can contain multiple categories
    self.address = event_data["address"]
    self.city = event_data["city"]
    self.state = event_data["state"]
    self.zip = event_data["zip"]
    self.address = event_data["address"]
  end

end
