require 'rails_helper'

RSpec.describe OverlayController, type: :controller do

  # let(:valid_attributes) { { name: 'Test Company' } }

  describe "GET #index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirects logged-in users to profile page' do

    end
  end

end
