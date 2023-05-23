# frozen_string_literal: true

Fabricator(:search_stat) do
  keyword            'MyString'
  ad_count           1
  link_count         1
  total_result_count 2
  raw_response       'MyText'
  user_id            1
end
