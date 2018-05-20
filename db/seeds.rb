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
         {k: "Supermarket", a: 43},
         {k: "coles", a: 43},
         {p: "AUSSIE FARMERS", a: 43},
         {k: "YOURGROCER", a: 43},
         {k: "Woolworths", a: 43},
         {p: "Hello Fresh", a: 43},
         {p: "UNIFIED THEORY", a: 43},
         {k: "FRUIT", a: 43},
         {k: "lamanna", a: 43},
         {k: "foodworks", a: 43},
         {p: "COFFEE", a: 43},
         {k: "meats", a: 43},
         {k: "meat", a: 43},
         {k: "nominees", a: 43},
         {k: "sub-newsagent", a: 43},

         #-44-Dining Out
         {p: "curry truck", a: 44},
         {p: "Solito Posto", a: 44},
         {p: "restauran", a: 44},
         {p: "FERROVIA DELI", a: 44},
         {p: "SIAM FLAVOUR", a: 44},
         {p: "WATERSIDE HOTEL", a: 44},
         {p: "GEORGE JONES", a: 44},
         {p: "brunetti", a: 44},
         {p: "khao san road", a: 44},
         {k: "Menulog", a: 44},
         {p: "healthy life", a: 44},
         
         #-45-Water
         {k: "water", a: 45},
         
         #-46-Internet
         {k: "INTERNODE", p: "intern ode", a: 46},
         
         #-47-Rates
         
         #-48-Electricity
         {k: "POWERSHOP", a: 48},
         
         #-49-Gas
         {p: "ORIGIN EN", a: 49},
         
         #-50-Mortgage
         
         #-51-Body Corporate
         {p: "Property r", a: 51},
         
         #-52-Rent
         
         #-53-Money Owed
         
         #-54-Online Subscriptions
         {k: "github.com", a: 54},
         
         #-55-Clothing
         {k: "spotlight", a: 55},
         {k: "asics", a: 55},
         {k: "bambooty", a: 55},
         {p: "BIG W", a: 55},
         {k: "MYER", a: 55},
         {k: "LOWES", a: 55},
         {k: "kmart", a: 55},
         {k: "BIRDSNEST", a: 55},
         {k: "cue", a: 55},
         {k: "donquijote", a: 55},
         {p: "BONDS AND CO", a: 55},
         
         #-56-Health
         {k: "dr", a: 56},
         {k: "dental", a: 56},
         {k: "pharmacy", a: 56},
         {k: "pharmacies", a: 56},
         {k: "ambulance", a: 56},
         {k: "hospital", p: "st vincents", a: 56},
         {k: "hlth", a: 56},
         {k: "births", a: 56},
         {k: "healthline", a: 56},
         {k: "HIF", a: 56},
         {k: "CAPELL", a: 56},
         {p: "HEALTH SERVICES", a: 56},
         {p: "western imaging", a: 56},
         {k: "ultrasound", a: 56},
         {k: "optec", a: 56},
         {p: "eye care", a: 56},
         {p: "unisex hair", a: 56},
         {k: "beautiology", a: 56},
         
         #-57-Medical
         
         #-58-Transport
         {k: "europcar", a: 58},
         {k: "UBER", a: 58},
         {k: "cabs", a: 58},
         {k: "cab", a: 58},
         {p: "PUBLIC TRANSPORT", a: 58},
         {k: "myki.", a: 58},
         
         # 59-Car Expenses
         {p: "auto & general", a: 59},
         {k: "vicroads", a: 59},
         {k: "CITYLINK", a: 59},
         {k: "hyundai", a: 59},
         {p: "super cheap", a: 59},
         {k: "racv", a: 59},

         # 60-Entertainment
         {k: "tickettek", a: 60},
         {k: "ticketmaster", a: 60},
         {k: "Village", a: 60},
         {k: "cinema", a: 60},
         {k: "cinemas", a: 60},
         {k: "nova", a: 60},
         {k: "Netflix.com", p: "NETFLIX COM", a: 60},
         {k: "www.Netflix.com", a: 60},
         {p: "STAN COM AU", a: 60},
         {p: "SPOTIFY", a: 60},
         {k: "readings", a: 60},
         {p: "TICKET SOLUTIONS-OZTIX", a: 60},
         {k: "steampowered.com", a: 60},
         {p: "steamgames.com", a: 60},

         # 61-Technology
         {k: "officeworks", a: 61},
         {k: "crazydomains.com.au", a: 61},
         {p: "jb hi fi", a: 61},
         {k: "AUSPI", a: 61},
         {k: "teamviewer", a: 61},
         {k: "computers", a: 61},
         {k: "msy", a: 61},
         {k: "DIGI-KEY", a: 61},
         {k: "ELEMENT14", a: 61},
         {k: "components", a: 61},
         {k: "jaycar", a: 61},
         {k: "electronics", a: 61},
         {k: "ricoh", a: 61},
         {p: "I Store", a: 61},
         {k: "*GOOGLE", a: 61},
         {k: "amazon", a: 61},

         # 62-Pet Expenses
         {k: "VETERINA", a: 62},
         {k: "VETERINARY", a: 62},

         # 63-Bank Fees
         {k: "Fee", a: 63},

         # 64-Holiday
         {p: "CARAVAN PK", a: 64},
         {k: "lodge", a: 64},
         {k: "airways", a: 64},
         {k: "qantas", a: 64},
         {k: "tullamarine", a: 64},

         # 65-Alcohol
         {p: "Dan murphy's", a: 65},
         {p: "Dan murphys", a: 65},
         {p: "1st choice", a: 65},
         {p: "prince wine", a: 65},
         {k: "wines", a: 65},
         {k: "cellars", a: 65},
         {k: "cellar", a: 65},

         # 66,   Home Improvements and Tools
         {k: "Bunnings", a: 66},
         {p: "Environment shop", a: 66},

         # 67, Pub
         {k: "tap", a: 67},
         {k: "brewing", a: 67},
         {k: "pub", a: 67},
         {k: "hotel", a: 67},
         {k: "bar", a: 67},
         {p: "welcome to thornbury", a: 67},
         {p: "drunken poet", a: 67},
         {p: "local hero", a: 67},
         
         # 68, Insurance
         {k: "RAFO", a: 68},
         {k: "insurance", a: 68},

         # 69, Paypal
         {k: "paypal", a: 69},
        ]

filters.each {|filter| create_filter(filter)}


