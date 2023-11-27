class ChangePactTypeToCategory < ActiveRecord::Migration[7.1]
  def change
    rename_column :pacts, :type, :category
  end
end
