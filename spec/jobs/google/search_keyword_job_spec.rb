# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchKeywordJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    context 'given a valid request' do
      it 'queues the job', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        expect { described_class.perform_later search_stat.id }.to have_enqueued_job(described_class)
      end

      it 'saves all result_links in the DataBase', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now search_stat.id

        expect(search_stat.result_links.count).to eq(45)
      end

      it 'sets the search stat status as completed', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now search_stat.id

        expect(search_stat.reload.status).to eq('completed')
      end

      it 'sets the links counts with the right values', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now search_stat.id

        search_stat.reload

        expect(search_stat.top_ad_count + search_stat.non_ad_count).to eq(45)
      end
    end
  end
end
