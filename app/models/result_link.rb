# frozen_string_literal: true

class ResultLink < ApplicationRecord
  belongs_to :search_stat, inverse_of: :result_links

  enum link_type: { ads_top: 0, ads_page: 1, non_ads: 2 }

  validates :url, presence: true
end
