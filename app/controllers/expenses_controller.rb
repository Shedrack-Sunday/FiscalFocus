class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def new
    @expense = Expense.new
    @categories = Category.all.order(:name)
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.categories << Category.find(params[:expense][:categories].to_i)
    @categories = Category.all
    @expense.user_id = current_user.id
    if @expense.save
      # success('New expense was successfully created.', redirect: true)
      redirect_to category_path(params[:expense][:categories].to_i)
    else
      # failure('Expense was not created because: ', @expense)
      render :new
    end
  end

  def destroy
    expense_to_delete = Expense.find(params[:id])
    expense_to_delete.destroy
    redirect_back(fallback_location: authenticated_root_path)
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :date_of_expense, categories: [])
  end

  private :expense_params
end
