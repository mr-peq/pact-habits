class AddCheckedStravaIdsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :checked_strava_ids, :integer, array: true, using: 'ARRAY[checked_strava_ids]::INTEGER[]'
  end
end
