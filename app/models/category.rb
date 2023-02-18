# Servicefiles from the server
class Category < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_and_belongs_to_many :expenses, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
  validates_length_of :name, maximum: 200
end
