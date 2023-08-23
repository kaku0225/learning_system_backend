class CreateBranchSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_schools do |t|
      t.string :name

      t.timestamps
    end
  end
end
