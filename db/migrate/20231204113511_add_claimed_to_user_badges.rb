class AddClaimedToUserBadges < ActiveRecord::Migration[7.1]
  def change
    add_column :user_badges, :claimed, :boolean, default: false
  end
end
