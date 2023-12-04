class RemoveLevelFromAvatars < ActiveRecord::Migration[7.1]
  def change
    remove_column :avatars, :level, :integer
  end
end
