class ChangeBadgesColumns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :badges, :user, null: false, foreign_key: true
    add_column :badges, :description, :string
    add_column :badges, :category, :string
  end
end
