# frozen_string_literal: true

Fabricator(:result_link) do
  link_type { ResultLink.link_types.keys.sample }
  url { FFaker::Internet.http_url }
end

Fabricator(:result_link_with_search_stat, from: :result_link) do
  search_stat { Fabricate(:search_stat) }
end
