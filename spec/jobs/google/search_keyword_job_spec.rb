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

        described_class.perform_now search_stat_id: search_stat.id

        expect(search_stat.result_links.count).to eq(45)
      end

      it 'sets the search stat status as completed', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now search_stat_id: search_stat.id

        expect(search_stat.reload.status).to eq('completed')
      end

      it 'sets the links counts with the right values', vcr: 'google_search/top_ads_1' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now search_stat_id: search_stat.id

        search_stat.reload

        expect(search_stat.top_ad_count + search_stat.non_ad_count).to eq(45)
      end
    end

    context 'given a 422 too many requests error' do
      it 'sets the search stat status as failed', vcr: 'google_search/too_many_requests' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now(search_stat_id: search_stat.id)

      rescue Google::ClientServiceError
        expect(search_stat.reload.status).to eq('failed')
      end

      it 'does not save any result_links', vcr: 'google_search/too_many_requests' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now(search_stat_id: search_stat.id)

      rescue Google::ClientServiceError
        expect(search_stat.reload.result_links.count).to eq(0)
      end

      it 'does not set any result count', vcr: 'google_search/too_many_requests' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now(search_stat_id: search_stat.id)

      rescue Google::ClientServiceError
        search_stat.reload

        expect([search_stat.ads_top_count, search_stat.ads_page_count, search_stat.non_ads_result_count]).to all(be_nil)
      end

      it 'does not set the html attribute', vcr: 'google_search/too_many_requests' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now(search_stat_id: search_stat.id)

      rescue Google::ClientServiceError
        expect(search_stat.reload.html).not_to be_present
      end

      it 'performs a SearchProgress job with the right user id', vcr: 'google_search/too_many_requests' do
        search_stat = Fabricate(:search_stat)

        described_class.perform_now(search_stat_id: search_stat.id)

      rescue Google::ClientServiceError
        expect(Google::SearchProgressJob).to have_received(:perform_now).with(search_stat.user_id).exactly(:once)
      end
    end
  end
end
