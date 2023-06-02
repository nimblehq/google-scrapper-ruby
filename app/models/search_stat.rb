# frozen_string_literal: true

class SearchStat < ApplicationRecord
  belongs_to :user
  attr_accessor :adwords_urls, :non_adwords_urls

  validates :keyword, presence: true
  validates :raw_response, presence: true

  enum status: { initialized: 0, running: 1, completed: 2, failed: 3 }
end
