class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_pacts
  has_many :pacts, through: :user_pacts

  has_one_attached :photo
  has_one_attached :avatar_picture
end
