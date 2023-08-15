class RemoveExcessColumn < ActiveRecord::Migration[7.0]
  def change
    remove_columns :users, :birthday, :cellphone, :phone, :school, :main_grade, :sub_grade, :county, :address, :branch_school
  end
end
