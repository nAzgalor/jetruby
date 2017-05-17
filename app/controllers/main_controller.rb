class MainController < ApplicationController
  def index
    @top_hotels = Hotel.top_5_hotels
  end
end
