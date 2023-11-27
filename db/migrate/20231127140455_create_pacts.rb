class CreatePacts < ActiveRecord::Migration[7.1]
  def change
    create_table :pacts do |t|
      t.string :type
      t.integer :distance
      t.integer :duration
      t.boolean :recurring
      t.integer :weekdays
      t.integer :xp
      t.integer :completion_duration
      t.boolean :challenge

      t.timestamps
    end
  end
end
