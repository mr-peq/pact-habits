class AddLevelReferenceToAvatar < ActiveRecord::Migration[7.1]
  def change
    add_reference :avatars, :level, null: false, foreign_key: true
  end
end
