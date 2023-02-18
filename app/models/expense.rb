class Expense < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories, dependent: :destroy

  validates :name, presence: true
  validates_length_of :name, maximum: 200
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 100_000_000 }
  validates :user_id, presence: true
  validates :date_of_expense, presence: true
  validates :categories, presence: true
end
