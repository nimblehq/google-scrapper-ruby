class ChangeLinkTypeToStringInResultLinks < ActiveRecord::Migration[7.0]
  def change
    change_column :result_links, :link_type, :string
  end
end
