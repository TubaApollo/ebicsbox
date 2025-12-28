#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sequel'
require 'epics'
require 'active_support/all'

# Connect to database
DB = Sequel.connect(ENV['DATABASE_URL'])

require_relative 'box/models/account'
require_relative 'box/models/ebics_user'
require_relative 'box/jobs/fetch_statements'

account = Box::Account[1]
puts "Account: #{account.name} (#{account.iban})"
puts "Active: #{account.active?}"
puts "EBICS Users: #{account.ebics_users.count}"

if account.active?
  begin
    puts "\nFetching statements..."
    job = Box::Jobs::FetchStatements.new
    result = job.fetch_for_account(account)
    puts "Result: #{result.inspect}"
  rescue => e
    puts "Error: #{e.class}: #{e.message}"
    puts e.backtrace.first(10).join("\n")
  end
else
  puts "Account not active!"
end
