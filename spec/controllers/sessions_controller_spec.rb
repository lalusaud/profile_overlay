require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "GET #create" do
    context "with valid params" do

      it 'creates a new user' do
        expect {
          get :create, provider: :facebook
        }.to change(User, :count).by(1)
      end

      it 'redirects to profile page' do
        expect(get :create, provider: :facebook)
        expect(response).to redirect_to(profile_path)
      end

    end
  end
end
