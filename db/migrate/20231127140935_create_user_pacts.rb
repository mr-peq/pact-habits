class CreateUserPacts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_pacts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pact, null: false, foreign_key: true
      t.datetime :deadline_at
      t.integer :bet
      t.references :beneficiary, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
