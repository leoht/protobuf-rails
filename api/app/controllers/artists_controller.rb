class ArtistsController < ApplicationController  
  before_filter :find_artist, except: :index
  
  def index
    send_data Artist.serialize_all
  end

  def show
    send_data @artist.serialize
  end

  def find_artist
    @artist = Artist.find params[:id]
  end
end 
