# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    @pagy, @search_stats = pagy(SearchStat.all, items: 8)
  end

  def show
    @search_stat = SearchStat.find(params[:id])
  end
end
