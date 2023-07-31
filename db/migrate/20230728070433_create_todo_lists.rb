class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :assign_id, null: false
      t.string :title, null: false
      t.text :content
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
