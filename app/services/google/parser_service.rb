# frozen_string_literal: true

module Google
  class ParserService
    NON_ADS_RESULT_SELECTOR = 'a[data-ved]:not([role]):not([jsaction]):not(.adwords):not(.footer-links)'
    AD_CONTAINER_ID = 'tads'
    ADWORDS_CLASS = 'adwords'

    def initialize(html_response:)
      @html = html_response

      @document = Nokogiri::HTML.parse(html_response) if html_response.body
    end

    # Parse html data and return a hash with the results
    def call
      return unless valid?

      mark_adword_links
      mark_footer_links

      present_parsed_data
    end

    private

    attr_reader :html, :document

    def valid?
      html.present? && document.present?
    end

    def mark_adword_links
      # Add a class to all AdWords link for easier manipulation
      document.css('div[data-text-ad] a[data-ved]').add_class(ADWORDS_CLASS)
    end

    def mark_footer_links
      # Mark footer links to identify them
      document.css('#footcnt a').add_class('footer-links')
    end

    def present_parsed_data
      {
        top_ad_count: ads_top_count,
        ad_count: ads_page_count,
        non_ad_count: non_ads_result_count,
        total_result_count: total_link_count,
        raw_response: html,
        result_links: result_links,
        status: :completed
      }
    end

    def ads_top_count
      document.css("##{AD_CONTAINER_ID} .#{ADWORDS_CLASS}").count
    end

    def ads_page_count
      document.css(".#{ADWORDS_CLASS}").count
    end

    def ads_top_urls
      document.css("##{AD_CONTAINER_ID} .#{ADWORDS_CLASS}").filter_map { |a_tag| a_tag['href'].presence }
    end

    def ads_page_urls
      document.css(".#{ADWORDS_CLASS}").filter_map { |a_tag| a_tag['href'].presence }
    end

    def non_ads_result_count
      document.css(NON_ADS_RESULT_SELECTOR).count { |a_tag| a_tag['href'].presence }
    end

    def non_ads_urls
      document.css(NON_ADS_RESULT_SELECTOR).filter_map { |a_tag| a_tag['href'].presence }
    end

    def total_link_count
      document.css('a').count
    end

    def result_links
      results = result_link_map(ads_top_urls, :ads_top)
      results += result_link_map(non_ads_urls, :non_ads)

      results
    end

    def result_link_map(urls, type)
      urls.map { |url| { url: url, link_type: type } }
    end
  end
end
