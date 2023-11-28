class Pact < ApplicationRecord
  CATEGORIES = ['Run', 'Cycle', 'Walk', 'Hike']
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
end
