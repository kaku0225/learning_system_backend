class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.text :jti, null: false, unique: true
      t.text :reset_jti

      t.timestamps
    end
  end
end
