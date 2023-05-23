class ChangeEmailDataTypeInUsers < ActiveRecord::Migration[6.0]
  def up
    enable_extension("citext")
    change_column :users, :email, :citext, default: "", null: false
  end

  def down
    change_column :users, :email, :string, default: "", null: false
    disable_extension("citext")
  end
end
