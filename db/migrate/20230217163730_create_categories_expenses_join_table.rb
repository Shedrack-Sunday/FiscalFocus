# frozen_string_literal: true
# rubocop:disable all
class CreateCategoriesExpensesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :expenses do |t|
      t.index :category_id
      t.index :expense_id
    end
  end
end
