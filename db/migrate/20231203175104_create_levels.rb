class CreateLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :levels do |t|
      t.integer :current, null: false
      t.integer :to_next

      t.timestamps
    end
  end
end
