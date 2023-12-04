class CreateUserBadges < ActiveRecord::Migration[7.1]
  def change
    create_table :user_badges do |t|

      t.timestamps
    end
  end
end
