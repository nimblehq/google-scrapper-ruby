# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Stats', type: :request do
  describe 'POST #create' do
    context 'given a valid file' do
      it 'inserts keywords to the database' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('keywords.csv', 'text/csv') }

        post :create, params: params

        expect(SearchStat.count).to eq(3)

        expect(page).to redirect_to search_stats_path
      end
    end

    context 'given an invalid file' do
      it 'does not insert keywords to the database' do
        user = Fabricate(:user)
        login_as_user user

        params = { csv_file: fixture_file_upload('invalid.csv', 'text/csv') }

        post :create, params: params

        expect(SearchStat.count).to eq(0)
      end
    end
  end
end
