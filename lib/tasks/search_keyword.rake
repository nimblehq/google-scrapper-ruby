# frozen_string_literal: true

# lib/tasks/search_keyword.rake

namespace :google do
  desc 'Schedule the SearchKeywordJob'
  task schedule_search_keyword_job: :environment do
    # Schedule the SearchKeywordJob for background processing
    Google::SearchKeywordJob.perform_later(search_stat_id: 1)

    puts 'SearchKeywordJob scheduled successfully.'
  end
end
