# frozen_string_literal: true

class ResultLink < ApplicationRecord
  enum link_type: { ads_top: 'ads_top', non_ads: 'non_ads' }

  belongs_to :search_stat, inverse_of: :result_links

  validates :url, presence: true
end
