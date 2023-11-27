class ChangeWeekdaysColumnTypeToArray < ActiveRecord::Migration[7.1]
  def change
    change_column :pacts, :weekdays, :integer, array: true, using: 'ARRAY[weekdays]::INTEGER[]'
  end
end
