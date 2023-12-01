class Avatar < ApplicationRecord
  belongs_to :user

  has_many :avatar_skills, dependent: :destroy
  has_many :skills, through: :avatar_skills
end
