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
    expect(page).to have_current_path(new_category_path)
  end

  scenario('confirm that the new category page has the correct fields') do
    expect(page).to have_field('category_name')
    expect(page).to have_field('image_picker')
  end

  scenario('create a new category') do
    within '.section-content form' do
      fill_in('category_name', with: 'New Category')
    end
    click_button('Create')
    expect(page).to have_current_path(authenticated_root_path)
  end
end
