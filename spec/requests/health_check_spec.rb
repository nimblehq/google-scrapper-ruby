# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HealthChecks', type: :request do
  describe 'GET /health_check' do
    it 'returns http success' do
      get '/health_check'
      expect(response).to have_http_status(:success)
    end

    it { is_expected.to route(:get, '/health_check').to('health_check#health_check') }
  end
end
