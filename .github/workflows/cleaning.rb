#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'octokit'

def get_number(line)
  regex = /[cC]lose[s]?[:]? #(?<number>[0-9]+)\.?/
  match = line.match(regex)
  match.named_captures["number"] unless match.nil?
end

repo = ENV["GITHUB_REPOSITORY"]
token = ENV["GITHUB_TOKEN"]
path = ENV["GITHUB_EVENT_PATH"]
client = Octokit::Client.new(:access_token => token)
file = File.read(path)
json = JSON.parse(file)
json['commits'].each do |commit|
  commit['message'].split("\n").each do |line|
    number = get_number(line)

    next if number.nil?

    issue = client.issue(repo, number)

    next if issue["pull_request"].nil?

    puts "==> Commit is closing PR ##{number}"

    pr = client.pull_request(repo, number)
    branches = [
      pr["head"]["ref"],
      "pr-#{number}",
    ]
    branches.each do |branch|
      begin
        if client.delete_branch(repo, branch)
          puts "  ==> Branch \"#{branch}\" deletion successful"
        else
          puts "  ==> Branch \"#{branch}\" deletion failure"
        end
      rescue StandardError => e
        puts "==> Error: #{e.message}"
      end
    end
  end
end
