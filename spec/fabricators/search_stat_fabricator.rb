# frozen_string_literal: true

Fabricator(:search_stat) do
  keyword { FFaker::Lorem.word }
  ad_count { rand(1..10) }
  link_count { rand(1..10) }
  total_result_count { rand(1..100) }
  raw_response { FFaker::HTMLIpsum.body }
  user { Fabricate(:user) }
end

Fabricator(:search_stat_parsed_with_links, from: :search_stat) do
  result_links(count: FFaker.rand(10) + 1)
end
