require 'capybara'
require 'capybara/rails'
require 'capybara/rspec'
require 'highline'

namespace :bank_download do
  desc "Download Westpac bank statements"
  task :westpac => :environment do

    cli=HighLine.new
    
    puts "Enter username:"
    username = STDIN.gets.chomp!

    password=cli.ask("Enter password:"){ |q| q.echo = "*" }

    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end

    session = Capybara::Session.new(:chrome)
    session.visit "https://www.westpac.com.au"

    if session.has_content?("Westpac")
      # Login
      puts "Login"

      session.click_on "Sign in"

      # Unhide the true username input box
      session.execute_script("$('input[type=hidden]').each (function() { this.type = 'text'; })")

      # Enter in login details and login
      session.first("input#username", visible: false).set(username)
      session.first("input#password").set(password)
      session.click_on "Sign in"

      # Download exported CSV
      session.visit "https://banking.westpac.com.au/secure/banking/reportsandexports/exportparameters/2/"

      session.first("input#DateRange_StartDate").set("01/09/2018")
      session.first("input#DateRange_EndDate").set("20/09/2018")

      session.first("input#File_type_4").click() # Select QIF format

      session.click_on "Export"

      sleep 5                   # Wait to download
      
    else
      puts ":( no tagline found, possibly something's broken"
      exit(-1)
    end
    
  end
end
