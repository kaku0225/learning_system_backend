class CreateTeacherSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_subjects do |t|
      t.integer :teacher_id, null: false
      t.integer :subject_id, null: false

      t.timestamps
    end
  end
end
