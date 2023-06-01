# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'fabrication'

# Generate dummy data for SearchStat
10.times do
  user = User.where(email: 'user@demo.com').first_or_create(Fabricate.attributes_for(:user, email: 'user@demo.com'))
  Fabricate.times(100, :search_stat_parsed_with_links, user: user)
end
