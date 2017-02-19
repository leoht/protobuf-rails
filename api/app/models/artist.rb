class Artist < ActiveRecord::Base
  has_many :venues
  
  def self.from_message(message)
    Artist.new.tap do |a|
      a.id = message.id
      a.name = message.name
      a.bio = message.bio
      a.genre = message.genre
    end
  end
  
  def to_message
    ArtistMessage.new(
      :id => a.id,
      :name => self.name,
      :bio => self.bio,
      :genre => self.genre
    )
  end
  
  def serialize
    ArtistMessage.encode(self.to_message)
  end
  
  def unserialize(data)
    message = ArtistMessage.decode(data)
    Artist.from_message(message)
  end
  
  def self.serialize_all
    message = ArtistCollectionMessage.new(
      :artists => Artist.all.map {|a|
        a.to_message
      }
    )
    ArtistCollectionMessage.encode(message)
  end
  
  def self.unserialize_all(data)
    artists = []
    message = ArtistCollectionMessage.decode(data)
    message.artists.map {|a|
      artists << Artist.from_message(a)
    }
    artists
  end
end
