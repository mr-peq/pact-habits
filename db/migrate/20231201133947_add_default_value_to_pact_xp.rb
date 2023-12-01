class AddDefaultValueToPactXp < ActiveRecord::Migration[7.1]
  def change
    change_column :pacts, :xp, :integer, default: 20
  end
end
