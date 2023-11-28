class AddDefaultStatusToUserPacts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :user_pacts, :status, from: nil, to: 0
  end
end
