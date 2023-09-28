class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.integer :teacher_id
      t.string :title
      t.datetime :start
      t.datetime :end
      t.boolean :all_day

      t.timestamps
    end
  end
end
