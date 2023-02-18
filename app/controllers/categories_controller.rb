# frozen_string_literal: true
# rubocop:disable all
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = setup_categories

    @total_amount = @categories.map(&:total_amount).compact.sum

    @this_month = 0

    @categories.each do |category|
      next unless category.expenses.length.positive?

      @this_month += category.expenses
                             .where('date_of_expense >= ?', Date.today.beginning_of_month)
                             .where('date_of_expense <= ?', Date.today.end_of_month)
                             .sum(:amount)
    end

    @highest_category = @categories.select(&:name).max_by(&:total_amount)
  end

  def new
    @category = Category.new
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to authenticated_root_path
  end

  def show
    data = Category.with_attached_image.find_by_sql("SELECT categories.*,
          COALESCE(SUM(expenses.amount), 0) as total_amount
            from categories
            LEFT JOIN categories_expenses ON categories.id = categories_expenses.category_id
            LEFT JOIN expenses on categories_expenses.expense_id = expenses.id
            WHERE categories.user_id = #{current_user.id}
            AND categories.id = #{params[:id]} GROUP BY categories.id ORDER BY categories.name ASC")
    @category = data[0]
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      #   success('New category was successfully created.', redirect: true)
      redirect_to authenticated_root_path
    else
      #   failure('Category was not created because: ', @category)
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end

  def setup_categories
    Category.with_attached_image.find_by_sql("SELECT categories.*,
            COALESCE(SUM(expenses.amount), 0) as total_amount
              from categories
              LEFT JOIN categories_expenses ON categories.id = categories_expenses.category_id
              LEFT JOIN expenses on categories_expenses.expense_id = expenses.id
              WHERE categories.user_id = #{current_user.id} GROUP BY categories.id ORDER BY categories.name ASC")
  end

  private :category_params, :setup_categories
end
