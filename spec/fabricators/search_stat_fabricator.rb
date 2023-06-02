# frozen_string_literal: true

demo_user = User.create(email: 'user@demo.com', password: 'Secret@11')

Fabricator(:search_stat) do
  keyword { FFaker::Lorem.word }
  ad_count { rand(1..10) }
  link_count { rand(1..10) }
  total_result_count { rand(1..100) }
  raw_response { FFaker::HTMLIpsum.body }
  user_id { demo_user.id }
end
