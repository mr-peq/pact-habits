class AddDefaultToChallengeInPacts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :pacts, :challenge, from: nil, to: false
  end
end
