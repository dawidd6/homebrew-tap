#:  * `pull-tap`
#:
#:  Pull bottles from my tap. The argument should be comma separated PR numbers.

require 'json'

module Homebrew
  exit if ARGV.empty?

  user = ENV["HOMEBREW_GITHUB_USER"] || ENV["USER"]
  tap = "dawidd6/homebrew-tap"
  url = "https://github.com/#{tap}/pull"
  pr_numbers = ARGV.first.to_s.split(",")
  pr_numbers_and_titles = {}

  pr_numbers.each do |pr_number|
    pull = JSON.parse(`hub api /repos/#{tap}/pulls/#{pr_number}`)
    pr_numbers_and_titles[pull["number"]] = pull["title"]
  end

  pr_numbers_and_titles.each do |pr_number, pr_title|
    puts "##{pr_number} \"#{pr_title}\""
  end

  print "==> Proceed?"
  STDIN.readline

  exit(1) unless system("git", "checkout", "master")

  pr_numbers_and_titles.each do |pr_number, _|
    exit(1) unless system("brew", "pull", "--bottle", "--bintray-org=#{user}", "--test-bot-user=#{user}", "#{url}/#{pr_number}")
  end
end
