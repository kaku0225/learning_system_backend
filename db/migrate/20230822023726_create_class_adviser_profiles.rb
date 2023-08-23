class CreateClassAdviserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :class_adviser_profiles do |t|
      t.integer :class_adviser_id
      t.string :cellphone

      t.timestamps
    end
  end
end
