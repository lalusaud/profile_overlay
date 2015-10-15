require 'rails_helper'

RSpec.describe OverlayController, type: :controller do

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "GET #index" do
    it 'does not redirects non logged-in users' do
      sign_in
      get :index
      expect(response).to have_http_status :success
    end

    it 'redirects logged-in users to profile page' do
      user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in user

      get :index
      expect(response).to redirect_to(profile_path)
    end
  end

  describe "GET #profile" do
    it 'requires login to view' do
      get :profile
      expect(response).to redirect_to root_path
    end

    it 'creates overlay images' do
      user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in user
      expect(response).to have_http_status :success
    end
  end

end
