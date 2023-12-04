class AddReferencesToUserBadges < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_badges, :user, null: false, foreign_key: true
    add_reference :user_badges, :badge, null: false, foreign_key: true
  end
end
