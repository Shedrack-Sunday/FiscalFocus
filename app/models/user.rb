class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :categories, dependent: :destroy
  has_many :expenses, dependent: :destroy

  # validations
  validates :name, presence: true
  validates_length_of :name, maximum: 200  
end
