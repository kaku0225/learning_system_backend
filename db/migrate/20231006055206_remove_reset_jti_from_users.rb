class RemoveResetJtiFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_columns :users, :reset_jti
  end
end
