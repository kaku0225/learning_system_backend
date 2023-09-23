class CreateAdministrationStaffProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :administration_staff_profiles do |t|
      t.integer :administration_staff_id
      t.string :gender
      t.string :cellphone
      t.string :school
      t.string :major

      t.timestamps
    end
  end
end
