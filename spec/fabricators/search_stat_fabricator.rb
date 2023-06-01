# frozen_string_literal: true

Fabricator(:search_stat) do
  keyword { FFaker::Lorem.word }
  ad_count { rand(1..10) }
  link_count { rand(1..10) }
  total_result_count { rand(1..100) }
  raw_response { FFaker::HTMLIpsum.body }
  user_id { Fabricate(:user).id }
end
