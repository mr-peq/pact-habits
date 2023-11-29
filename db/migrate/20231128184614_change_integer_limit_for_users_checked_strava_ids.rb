class ChangeIntegerLimitForUsersCheckedStravaIds < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :checked_strava_ids, :integer, limit: 8, array: true, using: 'ARRAY[checked_strava_ids]::INTEGER[]', default: []
  end
end
