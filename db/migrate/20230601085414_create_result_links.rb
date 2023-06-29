class CreateResultLinks < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext' unless extension_enabled?('citext')

    create_table :result_links do |t|
      t.references :search_stat, null: false, foreign_key: true
      t.integer :link_type, null: false
      t.citext :url, null: false

      t.timestamps
    end
  end
end
