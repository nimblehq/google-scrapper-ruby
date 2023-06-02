class AddStatusNonAdCountTopAdCountToSearchStats < ActiveRecord::Migration[7.0]
  def change
    add_column :search_stats, :non_ad_count, :integer, default: 0, null: false
    add_column :search_stats, :top_ad_count, :integer, default: 0, null: false
    add_column :search_stats, :status, :integer, default: 0, null: false

    add_index :search_stats, :status
  end
end
