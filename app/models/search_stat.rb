# frozen_string_literal: true

class SearchStat < ApplicationRecord
  validates :keyword, presence: true 
end
