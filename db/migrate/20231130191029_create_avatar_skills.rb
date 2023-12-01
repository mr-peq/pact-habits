class CreateAvatarSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :avatar_skills do |t|
      t.references :avatar, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
