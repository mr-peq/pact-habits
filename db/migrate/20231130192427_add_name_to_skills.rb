class AddNameToSkills < ActiveRecord::Migration[7.1]
  def change
    add_column :skills, :name, :string
  end
end
