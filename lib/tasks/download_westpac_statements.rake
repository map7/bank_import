require 'capybara'
require 'capybara/rails'
require 'capybara/rspec'
require 'highline'

DOWNLOAD_DIR="#{ENV['HOME']}/Downloads"
DOWNLOAD="#{DOWNLOAD_DIR}/Data.qif"
BAK="#{DOWNLOAD_DIR}/Data.qif.bak_#{Time.now.to_i}"

def initialise
  # Backup the old file
  FileUtils.mv "#{DOWNLOAD}","#{BAK}" if File.exists? "#{DOWNLOAD}"

  # Initialise Capybara
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  @session = Capybara::Session.new(:chrome)

  # Initialise Highline for asking questions
  @cli=HighLine.new

  # Setup dates as previous month range
  @start_date=Time.now.to_date.last_month.beginning_of_month
  @end_date=Time.now.to_date.last_month.end_of_month
end

def gather_details
  @username = @cli.ask "Enter username:"
  @password=@cli.ask("Enter password:"){ |q| q.echo = "*" }
end

def login
  puts "Login"
  @session.click_on "Sign in"

  # Unhide the true username input box
  @session.execute_script("$('input[type=hidden]').each (function() { this.type = 'text'; })")

  # Enter in login details and login
  @session.first("input#username", visible: false).set(@username)
  @session.first("input#password").set(@password)
  @session.click_on "Sign in"
end

def wait_for_download
  counter = 0
  while File.exists?("#{DOWNLOAD}") == false and counter < 15
    counter += 1
    sleep 1    
  end
end

def rename_download
  new_filename = "#{DOWNLOAD_DIR}/#{@start_date.strftime("%Y_%B")}_westpac.qif"
  FileUtils.mv(new_filename, "#{new_filename}.bak_#{Time.now.to_i}") if File.exists?(new_filename)
  FileUtils.mv("#{DOWNLOAD}", new_filename)
end

def download_qif
  @session.visit "https://banking.westpac.com.au/secure/banking/reportsandexports/exportparameters/2/"

  @session.first("input#DateRange_StartDate").set(@start_date.strftime("%d/%m/%Y"))
  @session.first("input#DateRange_EndDate").set(@end_date.strftime("%d/%m/%Y"))

  @session.first("input#File_type_4").click() # Select QIF format

  @session.click_on "Export"
  wait_for_download
  rename_download
end

def logout
  @session.click_on "Sign Out"
  puts "You have been signed out" if @session.has_content?("Signed out of Westpac Live")
end

namespace :bank_download do
  desc "Download Westpac bank statements"
  task :westpac => :environment do
    initialise
    gather_details

    @session.visit "https://www.westpac.com.au"

    if @session.has_content?("Westpac")
      login
      download_qif
      logout            
    else
      puts ":( no tagline found, possibly something's broken"
      exit(-1)
    end
  end
end
