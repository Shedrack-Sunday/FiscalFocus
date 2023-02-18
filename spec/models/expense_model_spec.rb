# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  before(:each) do
    User.destroy_all
    Category.destroy_all
    Expense.destroy_all

    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category, user: @user)
    @expense = FactoryBot.create(:expense, user: @user, categories: [@category])
  end

  it 'is invalid without a user' do
    @expense.user = nil
    expect(@expense).to_not be_valid
  end

  it 'is invalid without a date_of_expense' do
    @expense.date_of_expense = nil
    expect(@expense).to_not be_valid
  end

  it 'is invalid without a category' do
    @expense.categories = []
    expect(@expense).to_not be_valid
  end
end
