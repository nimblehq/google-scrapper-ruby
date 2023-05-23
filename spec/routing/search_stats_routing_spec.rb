# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchStatsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/search_stats').to route_to('search_stats#index')
    end
  end
end
