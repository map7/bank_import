# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Accounts seed
CSV.parse(File.read("#{Rails.root}/db/#{CHART_OF_ACCOUNTS}")) do |account|
  # Skip any lines beginning with # as these are comments.
  unless account[0] =~ /^#.*/ or account[0].nil? or Account.find_by_name(account[1].strip)
    Account.create(code: account[0].strip, name: account[1].strip)
  end
end

# Filter seed
["BP", "CALTEX", "7-ELEVEN", "PETROL"].each do |filter_keyword|
  unless Filter.find_by_keyword(filter_keyword)
      petrol.filters.create(keyword: filter_keyword,
                            account: Account.find_by_name("Petrol"))
  end
end

