class CreateStudentProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :student_profiles do |t|
      t.integer :student_id
      t.string :birthday
      t.string :cellphone, null: false
      t.string :phone
      t.string :school, null: false
      t.string :main_grade
      t.string :sub_grade
      t.string :county
      t.string :address
      t.string :branch_school

      t.timestamps
    end
  end
end
