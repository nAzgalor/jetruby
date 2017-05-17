require 'rails_helper'
require 'database_cleaner'

RSpec.describe Hotel, type: :model do
  DatabaseCleaner.strategy = :truncation

  let(:user) { User.create!(email: 'test1@example.com', password: 'password') }

  describe 'Hotel' do
    it 'has a valid argument' do
      # user = User.create(email: 'test@example.com', password: 'password')
      hotel = user.hotels.create(title: 'Test', star_rating_owner: 3)
      expect(hotel).to be_valid
    end

    it 'is invalid without title' do
      # user = User.create(email: 'test@example.com', password: 'password')
      hotel = user.hotels.create(star_rating_owner: 3)
      expect(hotel).to_not be_valid
    end

    it 'is invalid without star_rating_owner' do
      # user = User.create(email: 'test@example.com', password: 'password')
      hotel = user.hotels.create(title: 'test')
      expect(hotel).to_not be_valid
    end

    it 'is invalid when star_rating_owner more 5' do
      # user = User.create(email: 'test@example.com', password: 'password')
      hotel = user.hotels.create(title: 'Test', star_rating_owner: 6)
      expect(hotel).to_not be_valid
    end

    it 'check star_rating' do
      # user = User.create(email: 'test@example.com', password: 'password')
      hotel = user.hotels.create(title: 'Test', star_rating_owner: 3)
      expect(hotel.star_rating_owner).to eq hotel.star_rating
    end
  end

  DatabaseCleaner.clean
end
