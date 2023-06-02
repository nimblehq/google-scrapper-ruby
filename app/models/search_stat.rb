# frozen_string_literal: true

class SearchStat < ApplicationRecord
  validates :keyword, presence: true
  validates :raw_response, presence: true

  enum status: { initialized: 0, running: 1, completed: 2, failed: 3 }
end
