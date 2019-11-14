#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'octokit'
require 'colorize'

# "Closes" variants regex to capture the #number
regex = /[cC]lose[s]?[:]? #(?<number>[0-9]+)\.?/

# Github env variables
repo = ENV["GITHUB_REPOSITORY"]
token = ENV["GITHUB_TOKEN"]
path = ENV["GITHUB_EVENT_PATH"]

# Initialize Github API client
client = Octokit::Client.new(:access_token => token) if token

# Read event JSON object if defined, else - testing mode
file = if path
  File.read(path)
else
  <<~EOS
  {
    "commits": [
      {
        "added": [
          "test"
        ],
        "author": {
          "email": "dawidd0811@gmail.com",
          "name": "Dawid Dziurla",
          "username": "dawidd6"
        },
        "committer": {
          "email": "dawidd0811@gmail.com",
          "name": "Dawid Dziurla",
          "username": "dawidd6"
        },
        "distinct": true,
        "id": "895b7bac7456a4ba968e54df2a371b217245e931",
        "message": "up\\ncloses: #11\\nCloses #9.",
        "modified": [],
        "removed": [],
        "timestamp": "2019-09-27T23:27:39+02:00",
        "tree_id": "f6deb8fdf2b260a46f6aaaed5deb212e911cefd4",
        "url": "https://github.com/dawidd6/homebrew-test/commit/895b7bac7456a4ba968e54df2a371b217245e931"
      }, {
        "added": [
          "test"
        ],
        "author": {
          "email": "dawidd0811@gmail.com",
          "name": "Dawid Dziurla",
          "username": "dawidd6"
        },
        "committer": {
          "email": "dawidd0811@gmail.com",
          "name": "Dawid Dziurla",
          "username": "dawidd6"
        },
        "distinct": true,
        "id": "895b7bac7456a4ba968e54df2a371b217245e931",
        "message": "up\\ncloses #30\\nCloses: #12",
        "modified": [],
        "removed": [],
        "timestamp": "2019-09-27T23:27:39+02:00",
        "tree_id": "f6deb8fdf2b260a46f6aaaed5deb212e911cefd4",
        "url": "https://github.com/dawidd6/homebrew-test/commit/895b7bac7456a4ba968e54df2a371b217245e931"
      }
    ]
  }
  EOS
end

# Parse JSON object
json = JSON.parse(file)

# Loop over all commits
json['commits'].each do |commit|
  # Define numbers array which holds all PR numbers that one commit is closing
  numbers = []

  # Loop over commit message line by line
  commit['message'].split("\n").each do |line|
    # Check if line has any variation of "Closes" in it
    match = line.match(regex)

    # Next line if no match
    next if match.nil?

    # Get captured issue number
    number = match.named_captures["number"]

    # Next line if number is nil
    next if number.nil?

    # Check if issue is a PR
    issue = client.issue(repo, number) if token

    # Next line if issue is not a PR
    next if token && issue["pull_request"].nil?

    # Append number to numbers
    numbers << number
  end

  # Print header
  unless numbers.empty?
    prefix = "==>".blue
    numbers_joined = numbers.map{|number| ("#"+number).cyan}.join(", ")
    commit_id = commit["id"].magenta
    puts "#{prefix} Commit #{commit_id} is closing PRs: #{numbers_joined}".bold
  end

  # Loop over PR numbers
  numbers.each do |number|
    # Define which branches to delete and loop over them
    branches = []
    branches << "pr-#{number}"
    branches << client.pull_request(repo, number)["head"]["ref"] if token

    # Loop over branches, print and try to delete them
    branches.each do |branch|
      print "Deleting #{branch.yellow.bold} branch ..."
      begin
        if token && client.delete_branch(repo, branch)
          puts "done".green.bold
        else
          puts "failed".red.bold
        end
      rescue StandardError => e
        puts "Error: #{e.message}".red.bold
      end
    end
  end
end
