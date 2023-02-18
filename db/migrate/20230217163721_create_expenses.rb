# frozen_string_literal: true
# rubocop:disable all
class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.references :user, null: false, foreign_key: true
      t.date :date_of_expense

      t.timestamps
    end
  end
end
