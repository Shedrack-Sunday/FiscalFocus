require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    User.destroy_all
    @user = FactoryBot.create(:user)
  end

  it 'has a valid attributes' do
    expect(@user).to be_valid
  end

  it 'is invalid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid with a name longer than 200 characters' do
    @user.name = 'a' * 201
    expect(@user).to_not be_valid
  end

  it 'is invalid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end
end
