class HotelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = current_user.hotels.new
  end

  def create
    @hotel = current_user.hotels.new(hotel_attributes)
    @hotel.address = "#{params[:country]}, #{params[:state]}, #{params[:city]}, #{params[:street]}"
    if @hotel.save
      redirect_to root_path, notice: 'Hotel was created'
    else
      render :new
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    @comment = current_user.comments.new if current_user.present?
    @comments = @hotel.comments
  end

  private

  def hotel_attributes
    params.require(:hotel).permit(:title, :star_rating_owner, :is_breakfest, :room_description, :photo, :price_of_room)
  end
end
