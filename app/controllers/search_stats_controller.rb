# frozen_string_literal: true

require 'csv'

class SearchStatsController < ApplicationController
  ALLOWED_MIME_TYPE = 'text/csv'
  MAXIMUM_FILE_SIZE_BYTES = 1000000

  def new
    search_stat = SearchStat.new

    render :new, locals: { search_stat: search_stat }
  end

  def create
    csv_file = params[:csv_file]

    raise 'Invalid file type' unless csv_file.content_type == ALLOWED_MIME_TYPE
    raise 'File is too large' unless csv_file.size <= MAXIMUM_FILE_SIZE_BYTES

    csv_file_content = params[:csv_file].read
    keywords = CSV.parse(csv_file_content).flatten

    raise 'Invalid file data' unless keywords.any?

    keywords.map do |keyword|
      SearchStat.create({ keyword: keyword })
    end

    redirect_to root_path
  end
end
