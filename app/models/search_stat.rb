# frozen_string_literal: true

class SearchStat < ApplicationRecord
  validates :keyword, presence: true
  validates :raw_response, presence: true
end
