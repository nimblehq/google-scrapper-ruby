# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    search_keyword = params[:search_keyword]

    if search_keyword.present?
      @pagy, @search_stats = pagy(current_user.search_stats.where(keyword: search_keyword))
    else
      @pagy, @search_stats = pagy(current_user.search_stats)
    end
  end

  def show
    @search_stat = SearchStat.includes(:result_links).find(params[:id])
  end
end
