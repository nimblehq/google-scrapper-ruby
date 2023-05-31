# frozen_string_literal: true

class SearchStat < ApplicationRecord
  belongs_to :user
  attr_accessor :adwords_urls, :non_adwords_urls
end
