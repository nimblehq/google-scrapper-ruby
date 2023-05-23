# frozen_string_literal: true

class SearchStatsController < ApplicationController
  include Pagy::Backend

  # GET /search_stats
  def index
    @pagy, @search_stats = pagy(SearchStat.all)
  end
end
