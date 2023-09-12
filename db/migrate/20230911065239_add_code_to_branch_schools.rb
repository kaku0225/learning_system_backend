class AddCodeToBranchSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :branch_schools, :code, :string
  end
end
