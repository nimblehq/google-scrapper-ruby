# frozen_string_literal: true

class SearchStatsController < ApplicationController
  # GET /search_stats
  def index
    @search_query = params[:search_keyword]
    @search_stats = @search_query.present? ? perform_search(@search_query) : SearchStat.all
    @pagy, @search_stats = pagy(@search_stats)
  end

  def show
    @search_stat = SearchStat.find(params[:id])
    @search_stat.adwords_urls = retrieve_adwords_urls(@search_stat)
    @search_stat.non_adwords_urls = retrieve_non_adwords_urls(@search_stat)
  end

  private

  def perform_search(query)
    SearchStat.where('keyword ILIKE ?', "%#{query}%")
  end

  def retrieve_adwords_urls(_search_stat)
    # Dummy array of Non AdWords URLs
    [
      'https://www.example.com/advertiser1',
      'https://www.example.com/advertiser2',
      'https://www.example.com/advertiser3'
    ]
  end

  def retrieve_non_adwords_urls(_search_stat)
    # Dummy array of Non AdWords URLs
    [
      'https://www.example.com/advertiser1',
      'https://www.example.com/advertiser2',
      'https://www.example.com/advertiser3'
    ]
  end
end
