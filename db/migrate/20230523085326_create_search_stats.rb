class CreateSearchStats < ActiveRecord::Migration[7.0]
  def change
    create_table :search_stats do |t|
      t.string :keyword, null: false
      t.integer :ad_count, null: false, default: 0
      t.integer :link_count, null: false, default: 0
      t.bigint :total_result_count, null: false, default: 0
      t.text :raw_response, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :search_stats, :keyword
  end
end

//non_ad_count, top_ad_count, status


class CreateSearchStats < ActiveRecord::Migration[7.0]
  def change
    create_table :search_stats do |t|
      t.string :keyword, null: false
      t.integer :ad_count, null: false, default: 0
      t.integer :link_count, null: false, default: 0
      t.bigint :total_result_count, null: false, default: 0
      t.integer :top_advertisers_count, null: false, default: 0
      t.integer :total_advertisers_count, null: false, default: 0
      t.text :top_advertisers_urls, array: true, default: []
      t.integer :non_adwords_count, null: false, default: 0
      t.text :non_adwords_urls, array: true, default: []
      t.integer :total_links_count, null: false, default: 0
      t.text :page_html, null: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :search_stats, :keyword
  end
end
