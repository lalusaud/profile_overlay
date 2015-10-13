require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(uid: '123456', name: 'Alex Smith', image_url: 'http://example.com/test.jpg') }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid without uid' do
    user.uid = nil
    expect(user).to_not be_valid
  end

  it 'is invalid without name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is invalid without image_url' do
    user.image_url = nil
    expect(user).to_not be_valid
  end
end
