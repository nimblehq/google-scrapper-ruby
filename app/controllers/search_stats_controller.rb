# frozen_string_literal: true

require 'csv'

class SearchStatsController < ApplicationController
  ALLOWED_MIME_TYPE = 'text/csv'
  MAXIMUM_KEYWORDS = 1000

  # GET /search_stats
  def index
    @pagy, @search_stats = pagy(SearchStat.all)
  end

  def new
    search_stat = SearchStat.new

    render :new, locals: { search_stat: search_stat }
  end

  def create
    csv_file = params[:csv_file]

    raise 'Invalid file type' unless csv_file.content_type == ALLOWED_MIME_TYPE

    csv_file_content = params[:csv_file].read
    keywords = CSV.parse(csv_file_content).flatten.compact_blank

    raise 'Invalid file data' unless keywords.any?
    raise 'Too many keywords' unless keywords.count <= MAXIMUM_KEYWORDS

    keywords.map do |keyword|
      search_stat = SearchStat.new({ keyword: keyword, user_id: current_user.id })
      search_stat.save!
    end

    redirect_to search_stats_path
  end
end
