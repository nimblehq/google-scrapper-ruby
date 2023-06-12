# frozen_string_literal: true

class ResultLink < ApplicationRecord
  enum link_type: { ads_top: 0, non_ads: 1 }

  belongs_to :search_stat, inverse_of: :result_links

  validates :url, presence: true
end
