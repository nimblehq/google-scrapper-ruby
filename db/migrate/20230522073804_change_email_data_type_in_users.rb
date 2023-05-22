class ChangeEmailDataTypeInUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :email, :citext, default: "", null: false
  end

  def down
    change_column :users, :email, :string, default: "", null: false
  end
end
