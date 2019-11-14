#:  * `pull-tap` PR_NUMBERS
#:
#:  Pull bottles from my tap.
#:  The argument should be comma separated PR numbers.

require 'json'

module Homebrew
  # Exit if no PR numbers passed
  exit if ARGV.empty?

  # Define basic variables
  user = ENV["HOMEBREW_GITHUB_USER"] || ENV["USER"]
  repo = "homebrew-tap"
  url = "https://github.com/#{user}/#{repo}/pull"

  # Retrieve PR titles from Github
  pr_numbers_and_titles = {}
  pr_numbers = ARGV.first.to_s.split(",")
  pr_numbers.each do |pr_number|
    pull = JSON.parse(`hub api /repos/#{user}/#{repo}/pulls/#{pr_number}`)
    pr_numbers_and_titles[pull["number"]] = pull["title"]
  end

  # Print
  pr_numbers_and_titles.each do |pr_number, pr_title|
    puts "##{pr_number} \"#{pr_title}\""
  end

  # Confirm
  print "==> Proceed?"
  STDIN.readline

  # Switch to master
  safe_system("git", "checkout", "-q", "master")

  # Pull bottles
  pr_numbers_and_titles.each do |pr_number, _|
    safe_system("brew", "pull", "--bottle", "--bintray-org=#{user}", "--test-bot-user=#{user}", "#{url}/#{pr_number}")
  end
end
