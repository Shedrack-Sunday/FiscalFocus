# frozen_string_literal: true
# rubocop:disable all
require 'rails_helper'

RSpec.describe 'Categories List', type: :feature do
  before(:all) do
    User.destroy_all
    Category.destroy_all
    @user = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category, user: @user)
    @category2 = FactoryBot.create(:category, user: @user)
    m = 5
    while m > 0
      @expense = FactoryBot.create(:expense, user: @user, categories: [@category1])
      m -= 1
    end
  end

  before(:each) do
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Sign In')
  end

  scenario 'confirm that we are on the categories list page' do
    expect(page).to have_current_path(authenticated_root_path)
    expect(page).to have_content('This Month')
    expect(page).to have_content('EXPENSE SUMMARY')
    expect(page).to have_content('SPENDING CATEGORIES')
  end

  scenario 'confirm that the categories list page has the correct number of categories' do
    expect(page).to have_content(@category1.name)
    expect(page).to have_content(@category2.name)
    expect(page).to have_css('li.category-item', count: 2)
  end

  scenario 'when the add category button is clicked, it redirects to add category page' do
    click_link('New Category')
    expect(page).to have_current_path(new_category_path)
  end
end
