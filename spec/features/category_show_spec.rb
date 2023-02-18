require 'rails_helper'

RSpec.describe 'Category show', type: :feature do
  before(:all) do
    User.destroy_all
    Category.destroy_all
    @user = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category, user: @user)
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
    visit(category_path(@category1.id))
  end

  scenario 'confirm that we are on the correct page' do
    expect(page).to have_current_path(category_path(@category1.id))
    expect(page).to have_content(@category1.name)
    expect(page).to have_content('EXPENSES')
  end

  scenario 'confirm that the page has the correct number of expenses' do
    expect(page).to have_css('li.shadow', count: 5)
  end
end
