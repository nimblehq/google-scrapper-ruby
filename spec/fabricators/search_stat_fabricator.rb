# frozen_string_literal: true

Fabricator(:search_stat, class_name: SearchStat) do
  keyword { FFaker::Lorem.word }
  ad_count { rand(1..10) }
  link_count { rand(1..60) }
  total_result_count { rand(1..100) }
  non_ad_count { rand(1..40) }
  top_ad_count { rand(1..5) }
  status { rand(1..3) }
  raw_response { FFaker::HTMLIpsum.body }
  user { Fabricate(:user) }
end

Fabricator(:search_stat_parsed_with_links, from: :search_stat) do
  result_links(count: FFaker.rand(10) + 1)
end
