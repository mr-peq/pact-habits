class Avatar < ApplicationRecord
  belongs_to :user
  belongs_to :level

  has_many :avatar_skills, dependent: :destroy
  has_many :skills, through: :avatar_skills

  def to_next_level
    level.to_next - xp
  end
end
