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

    keywords.map do |keyword|
      SearchStat.insert({ keyword: keyword })
    end
  end
end
