class Pact < ApplicationRecord
  CATEGORIES = ['run', 'cycle', 'walk', 'hike']
  WEEKDAYS = {
    'Monday' => 0,
    'Tuesday' => 1,
    'Wednesday' => 2,
    'Thursday' => 3,
    'Friday' => 4,
    'Saturday' => 5,
    'Sunday' => 6
  }

  has_many :user_pacts
  has_many :users, through: :user_pacts

  validates :category, inclusion: { in: CATEGORIES }

  def ongoing_challengers
    user_pacts.where(status: "ongoing").map(&:user)
  end

  def achieved_challengers
    user_pacts.where(status: "achieved").map(&:user)
  end
end
