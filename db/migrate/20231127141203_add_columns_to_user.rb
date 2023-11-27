class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthday, :date
    add_column :users, :nickname, :string
    add_column :users, :strava_token, :text
    add_column :users, :total_xp, :integer
    add_column :users, :achieved_pacts, :integer
    add_column :users, :failed_pacts, :integer
  end
end
