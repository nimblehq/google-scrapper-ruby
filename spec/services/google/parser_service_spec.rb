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
  end
end
