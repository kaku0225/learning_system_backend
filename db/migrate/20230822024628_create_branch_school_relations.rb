class CreateBranchSchoolRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_school_relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :branch_school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
