class Venue < ActiveRecord::Base
  belongs_to :artist
  belongs_to :location

  def to_message
    VenueMessage.new(
      :id => self.id,
      :artist => self.artist.to_message,
      :location => self.location.to_message,
      :venue_date => self.venue_date.to_s
    )
  end

  def encode
    VenueMessage.encode(self.to_message)
  end

  def unserialize(data)
    message = VenueMessage.decode(data)
    self.id = message.id
    self.venue_date = message.venue_date.to_datetime
    self.artist = Artist.from_message(message.artist)
    self.location = Location.from_message(message.location)
  end
end
