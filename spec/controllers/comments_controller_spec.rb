require 'rails_helper'
require 'database_cleaner'

RSpec.describe CommentsController, type: :controller do
  DatabaseCleaner.strategy = :truncation

  describe 'POST create' do
    it 'new comment' do
      user = User.create(email: 'test@example.com', password: 'password')
      @hotel = user.hotels.create(title: '1-title', star_rating_owner: 1)

      sign_in user

      expect{ user.comments.create(description: 'new commnet', star_rating_user: 3, hotel_id: @hotel.id) }.to change{ Comment.count }.by(1)
    end
  end

  DatabaseCleaner.clean
end
