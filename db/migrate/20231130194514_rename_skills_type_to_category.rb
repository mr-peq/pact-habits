class RenameSkillsTypeToCategory < ActiveRecord::Migration[7.1]
  def change
    rename_column :skills, :type, :category
  end
end
