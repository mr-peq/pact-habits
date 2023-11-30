class CreateSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :skills do |t|
      t.string :type
      t.integer :dmg

      t.timestamps
    end
  end
end
