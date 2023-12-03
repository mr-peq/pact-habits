class AddXpToAvatars < ActiveRecord::Migration[7.1]
  def change
    add_column :avatars, :xp, :integer, default: 0
  end
end
