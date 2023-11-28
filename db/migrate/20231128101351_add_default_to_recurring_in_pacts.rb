class AddDefaultToRecurringInPacts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :pacts, :recurring, from: nil, to: false
  end
end
