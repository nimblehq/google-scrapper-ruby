# frozen_string_literal: true

class SearchStatsController < ApplicationController
  def new
    search_stat = SearchStat.new

    render :new, locals: {
      search_stat: @search_stat
    }
  end

  def create
    uploaded_file = params[:csv_file]
  end
end
