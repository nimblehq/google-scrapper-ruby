# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Stats', type: :request do
  describe 'POST #create' do
    context 'given a valid file' do
      it 'inserts keywords to the database and redirects to search stat index' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('keywords.csv', 'text/csv') }

        post search_stats_path, params: params

        expect(SearchStat.count).to eq(3)

        expect(page).to redirect_to search_stats_path
      end
    end

    context 'given an invalid file data' do
      it 'does not insert keywords to the database and raises an error' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('invalid_data.csv', 'text/csv') }

        expect { post search_stats_path, params: params }.to raise_error(RuntimeError, 'Invalid file data')

        expect(SearchStat.all.count).to eq(0)
      end
    end

    context 'given an invalid file type' do
      it 'does not insert keywords to the database and raises an error' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('invalid_type.txt', 'text/plain') }

        expect { post search_stats_path, params: params }.to raise_error(RuntimeError, 'Invalid file type')

        expect(SearchStat.all.count).to eq(0)
      end
    end

    context 'given too many keywords' do
      it 'does not insert keywords to the database and raises an error' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('too_many_keywords.csv', 'text/csv') }

        expect { post search_stats_path, params: params }.to raise_error(RuntimeError, 'Too many keywords')

        expect(SearchStat.all.count).to eq(0)
      end
    end
  end
end
