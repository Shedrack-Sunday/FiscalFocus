# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Category', type: :feature do
  before(:all) do
    User.destroy_all
    Category.destroy_all
    @user = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category, user: @user)
    @category2 = FactoryBot.create(:category, user: @user)
  end
  before(:each) do
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Sign In')
    visit(new_category_path)
  end
  scenario('confirm that we are on the new category page') do
  
  end
end