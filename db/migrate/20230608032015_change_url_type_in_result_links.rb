class ChangeUrlTypeInResultLinks < ActiveRecord::Migration[7.0]
  def change
    remove_index :result_links, :url

    change_column :result_links, :url, :string, null: false

    add_index :result_links, :url
  end
end
