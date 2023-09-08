class AddColumnPhoneAddressEnabledToBranchSchool < ActiveRecord::Migration[7.0]
  def change
    change_column :branch_schools, :name, :string, null: false
    add_column :branch_schools, :phone, :string
    add_column :branch_schools, :address, :string
    add_column :branch_schools, :enabled, :boolean, default: false
  end
end
