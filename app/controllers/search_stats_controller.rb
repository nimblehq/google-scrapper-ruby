# frozen_string_literal: true

require 'csv'

class SearchStatsController < ApplicationController
  def new
    search_stat = SearchStat.new

    render :new, locals: { search_stat: search_stat }
  end

  def create
    csv_file_content = params[:csv_file].read

    keywords = CSV.parse(csv_file_content).flatten

    if keywords.any?
      keywords.map do |keyword|
        SearchStat.insert({ keyword: keyword })
      end
  
      redirect_to search_stats_path
    else
      flash[:alert] = "You have selected file with invalid data"
    end
  end
end
