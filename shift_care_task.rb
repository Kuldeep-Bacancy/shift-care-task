#!/usr/bin/env ruby

require 'json'
require 'optparse'

begin
  #Parse command line options
  options = {}

  parser = OptionParser.new do |parser|
    parser.on("--file=FILE_NAME", "Specify JSON file with full path")
    parser.on("--search=VALUE", "Search By first name")
    parser.on("--field_name=FIELD_NAME", "specify Field Name")
    parser.on("--duplicates", "Find Duplicates")
  end

  parser.parse!(into: options)

  parser.on("-h", "--help", "Prints this help") do
    puts parser
    exit
  end

  #search clients by name
  def search_clients(clients, query, field_name)
    valid_fields = clients.first.keys
    raise Exception.new("You are trying to search with invalid field(#{field_name}). Please search with valid field(#{valid_fields})") unless valid_fields.include?(field_name)
    matching_clients = clients.filter { |client| client[field_name].downcase.include?(query.downcase) }
    matching_clients.each { |client| puts "ID: #{client['id']}, Full_Name: #{client['full_name']},  Email: #{client['email']}" }
  end

  #find duplicate emails
  def find_duplicate_emails(clients)
    email_count = Hash.new(0)
    clients.each do |client|
      email_count[client['email']] += 1
    end

    duplicate_emails = email_count.filter { |email, count| count > 1 }
    duplicate_emails.each { |email, count| puts "#{email} => #{count} duplicates found." }
  end

  # Main logic
  if options.empty?
    puts "Please provide a command (search or duplicates) and the required arguments."
  else
    file_path = options[:file]
    command_list = options.first
    command = command_list.first.to_s.downcase
    search_value = command_list.last.to_s.downcase

    raise Exception.new("Please specify file with full path!") if file_path.nil?

     # Load the JSON dataset
     clients_data = JSON.parse(File.read(file_path))

    case command
    when 'search'
      if search_value.nil?
        puts "Please provide a search query."
      else
        field_name = options[:field_name].nil? ? "full_name" : options[:field_name]
        search_clients(clients_data, search_value, field_name)
      end
    when 'duplicates'
      find_duplicate_emails(clients_data)
    else
      puts "Unknown command: #{command}"
    end
  end
rescue => e
  puts "Error: #{e.message}"
end
