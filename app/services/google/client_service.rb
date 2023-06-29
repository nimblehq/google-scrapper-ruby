# frozen_string_literal: true

module Google
  class ClientService
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
                 'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36'

    BASE_SEARCH_URL = 'https://www.google.com/search'

    SUCCESS_STATUS_CODE = '200'

    def initialize(keyword:, lang: 'en')
      @escaped_keyword = CGI.escape(keyword)
      @uri = URI("#{BASE_SEARCH_URL}?q=#{@escaped_keyword}&hl=#{lang}&gl=#{lang}")
    end

    def call
      result = HTTParty.get(@uri, { headers: { 'User-Agent' => USER_AGENT } })

      raise ClientServiceError unless valid_result? result

      result
    rescue HTTParty::Error, Timeout::Error, SocketError, ClientServiceError => e
      Rails.logger.error "Error: Query Google with '#{@escaped_keyword}' thrown an error: #{e}"

      raise ClientServiceError, 'Error fetching HTML result'
    end

    private

    def valid_result?(result)
      return false unless result
      return true if result.response.code == SUCCESS_STATUS_CODE
    end
  end
end
