# frozen_string_literal: true

module Google
  class ClientServiceError < StandardError; end

  class SearchKeywordJob < ApplicationJob
    queue_as :default

    def perform(search_stat_id:)
      search_stat = SearchStat.find search_stat_id
      html_result = Google::ClientService.new(keyword: search_stat.keyword).call
      parsed_attributes = ParserService.new(html_response: html_result).call

      update_search_stat(search_stat, parsed_attributes)
    rescue ActiveRecord::RecordNotFound, ClientServiceError, ArgumentError, ActiveRecord::RecordInvalid
      update_search_stat_status search_stat, :failed
    end

    def update_search_stat(search_stat, attributes)
      SearchStat.transaction do
        search_stat.result_links.create(attributes[:result_links])

        search_stat.update! attributes.except(:result_links)
      end
    end

    def update_search_stat_status(search_stat, status)
      search_stat.update! status: status
    end
  end
end
