class CreateSearchStats < ActiveRecord::Migration[7.0]
  def change
    create_table :search_stats do |t|
      t.string :keyword
      t.integer :ad_count
      t.integer :link_count
      t.bigint :total_result_count
      t.text :raw_response
      t.bigint :user_id

      t.timestamps
    end
  end
end
