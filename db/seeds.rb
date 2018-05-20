# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

def acc(code)
  Account.find_by_code(code)
end

def create_filter(filter)
  
  Filter.find_or_create_by(keyword: filter[:k],
                           phrase: filter[:p],
                           account: acc(filter[:a]))
end

# Accounts seed
CSV.parse(File.read("#{Rails.root}/db/#{CHART_OF_ACCOUNTS}")) do |account|
  # Skip any lines beginning with # as these are comments.
  unless account[0] =~ /^#.*/ or account[0].nil? or Account.find_by_name(account[1].strip)
    Account.create(code: account[0].strip, name: account[1].strip)
  end
end


filters=[
         # 41-Petrol
         {k: "BP", a: 41},
         {k: "CALTEX", a: 41},
         {k: "7-ELEVEN", a: 41},
         {k: "PETROL", a: 41},
         {k: "SHELL", a: 41},

         # 42-Pharmacy
         {k: "Chemist", a: 42},

         # 43-Food
         {p: "AUSSIE FARMERS", a: 43},
         {k: "YOURGROCER", a: 43},
         {k: "Woolworths", a: 43},
         {p: "Hello Fresh", a: 43},
         {p: "UNIFIED THEORY", a: 43},
         {k: "FRUIT", a: 43},
         {k: "LEMANNA", a: 43},

         #-44-Dining Out
         {p: "Solito Posto", a: 44},
         {p: "FERROVIA DELI", a: 44},
         {p: "SIAM FLAVOUR", a: 44},
         {p: "WATERSIDE HOTEL", a: 44},
         
         #-45-Water
         
         #-46-Internet
         {k: "INTERNODE", a: 46},
         
         #-47-Rates
         
         #-48-Electricity
         {k: "POWERSHOP", a: 48},
         
         #-49-Gas
         
         #-50-Mortgage
         
         #-51-Body Corporate
         {p: "Property r", a: 51},
         
         #-52-Rent
         
         #-53-Money Owed
         
         #-54-Online Subscriptions
         {k: "github.com", a: 54},
         
         #-55-Clothing
         {k: "LOWES", a: 55},
         {k: "BIRDSNEST", a: 55},
         {p: "BONDS AND CO", a: 55},
         
         #-56-Health
         {k: "HIF", a: 56},
         
         #-57-Medical
         
         #-58-Transport
         {k: "UBER", a: 58},
         {p: "PUBLIC TRANSPORT", a: 58},
         
         # 59-Car Expenses
         {k: "CITYLINK", a: 59},

         # 60-Entertainment
         {k: "Village", a: 60},
         {k: "Netflix.com", p: "NETFLIX COM", a: 60},
         {p: "STAN COM AU", a: 60},
         {p: "SPOTIFY", a: 60},

         # 61-Technology
         {k: "AUSPI", a: 61},

         # 62-Pet Expenses
         {k: "VETERINA", a: 62},

         # 63-Bank Fees
         {k: "Fee", a: 63},
        ]

filters.each {|filter| create_filter(filter)}


