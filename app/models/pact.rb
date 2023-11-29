class Pact < ApplicationRecord
  CATEGORIES = ['run', 'cycle', 'walk', 'hike']
  WEEKDAYS = {
    0 => 'Sunday',
    1 => 'Monday',
    2 => 'Tuesday',
    3 => 'Wednesday',
    4 => 'Thursday',
    5 => 'Friday',
    6 => 'Saturday'
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
