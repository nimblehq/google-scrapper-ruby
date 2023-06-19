# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    search_stats_query.call
    @pagy, @search_stats = pagy(search_stats_query.keywords)
  end

  def show
    @search_stat = SearchStat.includes(:result_links).find(params[:id])
  end

  private

  def search_stats_query
    @search_stats_query ||= SearchStatsQuery.new(current_user.search_stats, permitted_params)
  end

  def permitted_params
    params.permit(:keyword)
  end
end
