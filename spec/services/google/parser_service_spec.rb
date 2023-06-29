# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::ParserService, type: :service do
  describe '#call' do
    context 'when parsing a page having 1 top ad' do
      it 'counts exactly 1 top ad', vcr: 'google_search/top_ads_1' do
        result = Google::ClientService.new(keyword: 'squarespace').call

        expect(described_class.new(html_response: result).call[:top_ad_count]).to eq(1)
      end
    end

    context 'when parsing a page having 3 top ads, 3 bottom ads and 14 non ad links' do
      it 'counts exactly 3 top ads', vcr: 'google_search/top_ads_6' do
        result = Google::ClientService.new(keyword: 'vpn').call

        expect(described_class.new(html_response: result).call[:top_ad_count]).to eq(3)
      end

      it 'counts exactly 6 ads in total', vcr: 'google_search/top_ads_6' do
        result = Google::ClientService.new(keyword: 'vpn').call

        expect(described_class.new(html_response: result).call[:ad_count]).to eq(6)
      end

      it 'finds exactly the 3 top ads urls', vcr: 'google_search/top_ads_6' do
        result = Google::ClientService.new(keyword: 'vpn').call

        result_links = described_class.new(html_response: result).call[:result_links]

        top_ads_urls = result_links.select { |link| link[:link_type] == :ads_top }.pluck(:url)

        expect(top_ads_urls).to contain_exactly('https://cloud.google.com/free', 'https://www.expressvpn.com/', 'https://www.top10vpn.com/best-vpn-for-vietnam/')
      end

      it 'counts exactly 14 non ad results', vcr: 'google_search/top_ads_6' do
        result = Google::ClientService.new(keyword: 'vpn').call

        expect(described_class.new(html_response: result).call[:non_ad_count]).to eq(14)
      end

      it 'gets 14 non_ads result_links', vcr: 'google_search/top_ads_6' do
        result = Google::ClientService.new(keyword: 'vpn').call

        result_links = described_class.new(html_response: result).call[:result_links]

        non_ads = result_links.select { |link| link[:link_type] == :non_ads }

        expect(non_ads.length).to eq(14)
      end

      it 'gets exactly 113 links', vcr: 'google_search/top_ads_6' do
        # Counted from cassette html raw code
        result = Google::ClientService.new(keyword: 'vpn').call

        expect(described_class.new(html_response: result).call[:total_result_count]).to eq(113)
      end
    end
  end
end
