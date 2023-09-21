class CreateTeacherProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_profiles do |t|
      t.integer :teacher_id
      t.string :gender
      t.string :cellphone
      t.string :school
      t.string :major

      t.timestamps
    end
  end
end
