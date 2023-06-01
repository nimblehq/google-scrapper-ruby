# frozen_string_literal: true

class SearchStat < ApplicationRecord
  has_many :result_links, inverse_of: :search_stat, dependent: :destroy
  belongs_to :user

  validates :keyword, presence: true, length: { maximum: 255 }
  validates :raw_response, presence: true
end
