# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    @pagy, @search_stats = pagy(current_user.search_stats)
  end

  def show
    @search_stat = SearchStat.includes(:result_links).find(params[:id])
  end
end
