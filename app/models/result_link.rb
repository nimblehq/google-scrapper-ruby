# frozen_string_literal: true

class ResultLink < ApplicationRecord
  enum link_type: { ads_top: 0, ads_page: 1, non_ads: 2 }

  belongs_to :search_stat, inverse_of: :result_links

  validates :url, presence: true
end
