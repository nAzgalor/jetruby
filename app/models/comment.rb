class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, uniqueness: { scope: :hotel_id,
    message: 'You have already commented' }

  validates :star_rating_user, inclusion: { in: [1, 2, 3, 4, 5], message: "%{value} not valid" }

  after_create :rating_calculation

  private

  def rating_calculation
    ratings_arr = Comment.where(hotel_id: hotel_id).pluck(:star_rating_user)
    hotel = Hotel.find(hotel_id)
    ratings_arr << hotel.star_rating_owner
    new_rating = (ratings_arr.sum.fdiv(ratings_arr.size.to_f)).round(2)
    hotel.update(star_rating: new_rating)
  end
end
