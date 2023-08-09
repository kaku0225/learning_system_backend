class AddOtherSignUpInfoToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :birthday
      t.string :cellphone, null: false
      t.string :phone
      t.string :school, null: false
      t.string :main_grade
      t.string :sub_grade
      t.string :county
      t.string :address
      t.string :branch_school
      t.boolean :enabled, default: false
    end
  end
end
