# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'fabrication'

Fabricate(:user, email: 'demo@example.com', password: 'nimbleHq1234')

# Generate dummy data for SearchStat
10.times do
  Fabricate(:search_stat)
end
