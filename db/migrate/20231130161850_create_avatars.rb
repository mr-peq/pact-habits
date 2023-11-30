class CreateAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :avatars do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :level, default: 1
      t.integer :health, default: 100
      t.integer :attack, default: 10
      t.integer :crit_rate, default: 2
      t.integer :magic_power, default: 10
      t.integer :defense, default: 10
      t.integer :mana, default: 100
      t.integer :speed, default: 10
      t.integer :stamina, default: 10

      t.timestamps
    end
  end
end
