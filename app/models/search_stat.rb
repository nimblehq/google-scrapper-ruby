# frozen_string_literal: true

class SearchStat < ApplicationRecord
  validates :keyword, presence: true, length: { maximum: 255 }
  validates :raw_response, presence: true

  belongs_to :user
  has_many :result_links, inverse_of: :search_stat, dependent: :destroy
end
