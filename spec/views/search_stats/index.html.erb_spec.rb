# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'search_stats/index', type: :view do
  before(:each) do
    assign(:search_stats, [
             SearchStat.create!(
               keyword: 'Keyword',
               ad_count: 2,
               link_count: 3,
               total_result_count: 22,
               raw_response: 'MyText',
               user_id: 1
             ),
             SearchStat.create!(
               keyword: 'Keyword',
               ad_count: 2,
               link_count: 3,
               total_result_count: 22,
               raw_response: 'MyText',
               user_id: 1
             )
           ])
  end

  it 'renders a list of search_stats' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Keyword'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(1.to_s), count: 2
  end

  it 'renders a list of search_stats to check counts' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(22.to_s), count: 2
  end
end
