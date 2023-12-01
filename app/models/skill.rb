class Skill < ApplicationRecord
  has_many :avatar_skills
  has_many :avatars, through: :avatar_skills

end
