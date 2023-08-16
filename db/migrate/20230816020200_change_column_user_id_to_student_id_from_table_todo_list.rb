class ChangeColumnUserIdToStudentIdFromTableTodoList < ActiveRecord::Migration[7.0]
  def change
    rename_column :todo_lists, :user_id, :student_id
  end
end
