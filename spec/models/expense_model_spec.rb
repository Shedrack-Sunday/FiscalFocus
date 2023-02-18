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

  it 'has valid attributes' do
    expect(@expense).to be_valid
  end

  it 'is invalid without a name' do
    @expense.name = nil
    expect(@expense).to_not be_valid
  end

  it 'is invalid with a name longer than 200 characters' do
    @expense.name = 'a' * 201
    expect(@expense).to_not be_valid
  end

  it 'is invalid without an amount' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end

  it 'is invalid with an amount less than 0' do
    @expense.amount = -1
    expect(@expense).to_not be_valid
  end

  it 'is invalid with an amount greater than 100_000_000' do
    @expense.amount = 100_000_001
    expect(@expense).to_not be_valid
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