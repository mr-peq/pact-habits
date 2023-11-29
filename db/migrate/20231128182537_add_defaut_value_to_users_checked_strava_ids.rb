class AddDefautValueToUsersCheckedStravaIds < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :checked_strava_ids, :integer, array: true, using: 'ARRAY[checked_strava_ids]::INTEGER[]', default: []
  end
end
