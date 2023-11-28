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
  has_one_attached :photo
end
