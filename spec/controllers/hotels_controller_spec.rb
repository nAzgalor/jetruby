require 'rails_helper'
require 'database_cleaner'

RSpec.describe HotelsController, type: :controller do
  DatabaseCleaner.strategy = :truncation

  before(:all) do
    @user = User.create(email: 'test@example.com', password: 'password')
    @hotel1 = @user.hotels.create(title: '1-title', star_rating_owner: 1)
    @hotel2 = @user.hotels.create(title: '2-title', star_rating_owner: 5)
  end

  context 'with render views' do
    render_views

    describe 'GET index' do
      it 'assign @hotels' do
        test_hotels = Hotel.all
        get :index
        expect(assigns(:hotels)).to eq(test_hotels)
      end

      it 'render index' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'GET show' do
      it 'assign @hotel' do
        get :show, params: { id: @hotel1.id }, flash: {}
        expect(assigns(:hotel).title).to eq('1-title')
        expect(response).to render_template('show')
      end
    end

    describe 'GET NEW' do
      let(:valid_attribute) {{title: 'Hotel', star_rating_owner: 3}}
      let(:invalid_attribute) {{title: ''}}

      it 'valid attributes' do
        sign_in @user
        get :new
        expect(response).to render_template('new')
        hotel = @user.hotels.create(valid_attribute)
        expect(hotel).to be_valid
      end

      it 'invalid attribute' do
        sign_in @user
        get :new
        expect(response).to render_template('new')
        hotel = @user.hotels.create(invalid_attribute)
        expect(hotel).to_not be_valid
      end
    end

  end

  context 'without render views' do
    describe 'POST create' do
      it 'new hotel' do
        sign_in @user

        expect{
          post :create, params: { hotel: { title: 'new hotel', star_rating_owner: 3, user_id: @user.id }}
        }.to change(Hotel,:count).by(1)
      end
    end
  end

  DatabaseCleaner.clean
end
