class AddStatsAndSkillsToAvatar < ActiveRecord::Migration[7.1]
  def change
    add_column :avatars, :magic_defense, :integer, default: 10
    add_column :avatars, :upgrade_points, :integer, default: 4
  end
end
