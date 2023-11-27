class CreateBeneficiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :beneficiaries do |t|
      t.string :name
      t.string :logo_src

      t.timestamps
    end
  end
end
