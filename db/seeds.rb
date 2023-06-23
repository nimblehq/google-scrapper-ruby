# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'fabrication'

# Generate dummy data for SearchStat

user = User.find_or_initialize_by(email: 'user@demo.com') do |user|
  user.password = 'aaaaaaA1'
end

10.times do
  Fabricate.times(100, :search_stat_parsed_with_links, user: user)
end
