require 'rails_helper'

RSpec.feature "Static pages view", type: :feature do

  describe 'index page' do
    before(:each) { visit root_path }

    it 'has the Login to Facebook link' do
      expect(page).to have_link('Login with Facebook', href: auth_provider_url)
    end

    it 'has right title and guest login message' do
      expect(page).to have_title('NP Profile Image Overlay')
      expect(page).to have_selector('h1', 'NP Profile Image Overlay')
      expect(page).to have_content('Hello Guest')
    end
  end

end
