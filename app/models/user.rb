class User < ApplicationRecord

  has_secure_password
  has_many :appointments
  has_many :events, through: :appointments

  def upcoming_events
    events.all.select do |event|
      event.start_time > Time.now
    end
  end

end
