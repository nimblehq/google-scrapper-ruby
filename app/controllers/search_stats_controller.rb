# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    @search_stats = SearchStat.all
  end
end
